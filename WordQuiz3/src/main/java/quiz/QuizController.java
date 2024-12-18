package quiz;

import java.io.IOException;
import java.lang.reflect.Method;
import java.sql.SQLException;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;

import comment.CommentDao;
import comment.CommentDto;
import comment.replyDto;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import user.UserDao;
import user.UserDto;

@WebServlet("/quiz.nhn")
@MultipartConfig(maxFileSize = 1024*1024*2, location= "c:/Temp/img")
public class QuizController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private ChatBotService chatBotService;
	private QuizService quizService;
	private UserDao userDao;
	private CommentDao commentDao;
	private ServletContext ctx;

	// 웹 리소스 기본 경로 지정
	private final String START_PAGE = "user/login.jsp";
	
	public void init(ServletConfig config) throws ServletException {

		super.init(config);
		ctx = getServletContext();
		chatBotService = new ChatBotService();
		quizService = new QuizService();
		userDao = new UserDao();
		commentDao = new CommentDao();
		
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String action = request.getParameter("action");
		System.out.println(action);
		
		// 자바 리플렉션을 사용해 if, switch 없이 요청에 따라 구현 메서드가 실행되도록 함. 즉 action이름과 동일한 메서드를 호출
		// 리플렉션은 구체적인 클래스 타입을 모를때 사용
		Method m;
		String view = null;
		// action 파라미터 없이 접근한 경우
		if (action == null) {
			action = "loginPage";
		}
		try {
			// 현재 클래스에서 action 이름과 HttpServletRequest 를 파라미터로 하는 메서드 찾음
			m = this.getClass().getMethod(action, HttpServletRequest.class, HttpServletResponse.class);
			// 메서드 실행후 리턴값 받아옴
			view = (String) m.invoke(this, request, response);
			System.out.println(view);
		} catch (NoSuchMethodException e) {
			e.printStackTrace();																																							
			// 에러 로그를 남기고 view 를 로그인 화면으로 지정, 앞에서와 같이 redirection 사용도 가능.
			ctx.log("요청 action 없음!!");
			request.setAttribute("error", "action 파라미터가 잘못 되었습니다!!");
			view = START_PAGE;
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (view.startsWith("redirect:/")	) {
			// redirect:/ 문자열 이후 경로만 가지고 옴
			String rview = view.substring("redirect:/".length());
			response.sendRedirect(rview);
		} else {
			// 지정된 뷰로 포워딩, 포워딩시 컨텍스트경로는 필요없음.
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);
		}

	}

	// 실제 퀴즈가 진행되는 페이지
	public String quizPage(HttpServletRequest request, HttpServletResponse response) {

        try {
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            
            List<QuizDto> list = quizService.getRandomQuizList();
            request.setAttribute("quizList", list);
            
        } catch (Exception e) {
        	System.out.println(e.getMessage());
        }
        
        return "quiz/quizView.jsp";
	}
	
	// 퀴즈를 만들어주는 페이지 (테스트를 위해 한번씩 실행하고 기다리셈.)
	public String getQuiz(HttpServletRequest request, HttpServletResponse response) {
		
        try {
        	chatBotService.getQuiz(15);
            
        } catch (Exception e) {
        	System.out.println(e.getMessage());
        }
        
        return "redirect:/quiz.nhn?action=quizPage";
	}
	
	// 해설 페이지
	public String commentaryPage(HttpServletRequest request, HttpServletResponse response)
	{	
		String quizIdList = request.getParameter("quizIdList");
		String quizFlagList = request.getParameter("quizFlagList");
		
		List<QuizDto> list = quizService.getQuizList(quizIdList);
		List<String> flagList = List.of(quizFlagList.split(","));
		Integer correctCnt = (int) flagList.stream().filter(s -> Integer.parseInt(s) == 1).count();
		
		request.setAttribute("quizList", list);
		request.setAttribute("quizFlagList", flagList);
		request.setAttribute("correctCnt", correctCnt);
		
		return "quiz/commentaryView.jsp";
	}
	
	// 로그인 페이지
	public String loginPage(HttpServletRequest request, HttpServletResponse response)
	{
		
		return "user/loginView.jsp";
	}
	
	// 회원가입 페이지
	public String registerPage(HttpServletRequest request, HttpServletResponse response)
	{
		
		return "user/registerView.jsp";
	}
	
	// 메인페이지
	public String mainPage(HttpServletRequest request, HttpServletResponse response)
	{
		
		return "quiz/mainView.jsp";
	}
	
	// 마이페이지
	public String myPage(HttpServletRequest request, HttpServletResponse response)
	{
		HttpSession session = request.getSession(); // 로그인시 세션 만들어서 user_no으로 유저번호 넘겨줘야함
		int user_no= (int)session.getAttribute("user_no");
		List<replyDto> list;
		try {
			UserDto u = userDao.getUser(user_no);
			request.setAttribute("users", u);
			list = commentDao.getComment(user_no);
			request.setAttribute("replylist", list);
		} catch (SQLException e) {
			e.printStackTrace();
			ctx.log("개인정보를 가져오는 과정에서 문제 발생!!");
			request.setAttribute("error", "개인정보를 정상적으로 가져오지 못했습니다!!");
		}
		return "user/myPageView.jsp";
	}
	
	// 랭킹페이지
	public String rankingPage(HttpServletRequest request, HttpServletResponse response)
	{
		
		return "user/rankingView.jsp";
	}
	
	// 유저 정보 페이지
	public String userInfoPage(HttpServletRequest request, HttpServletResponse response)
	{
		int target_no = Integer.parseInt(request.getParameter("target_no"));// /quiz.nhn?action=guserInfoPage&user_no=랭킹 유저 번호(링크 형태)
		List<replyDto> list;
		try {
			UserDto u = userDao.getUser(target_no);
			request.setAttribute("users", u);
			list = commentDao.getComment(target_no);
			request.setAttribute("replylist", list);
		} catch (SQLException e) {
			e.printStackTrace();
			ctx.log("개인정보를 가져오는 과정에서 문제 발생!!");
			request.setAttribute("error", "개인정보를 정상적으로 가져오지 못했습니다!!");
		}
		return "user/userInfoView.jsp";
	}
	public String addComments(HttpServletRequest request, HttpServletResponse response) {
		CommentDto c = new CommentDto();
		HttpSession session = request.getSession(); //세션을 통해 유저 정보 입력
		int user_no= (int)session.getAttribute("user_no");
		int target_no = Integer.parseInt(request.getParameter("target_no"));// userInfoPage의 페이지에서 사용하기 때문에 request.getParameter("user_no")의 데이터가 남아있음
		try {
			c.setContent(request.getParameter("content"));
			c.setWriter_no(user_no);
			c.setTarget_no(target_no);
			commentDao.addComment(c);
		}catch (Exception e) {
			e.printStackTrace();
			ctx.log("댓글 추가 과정에서 문제 발생!!");
			request.setAttribute("error", "댓글이 정상적으로 등록되지 않았습니다!!");
			return userInfoPage(request,response);
		}

		return "redirect:/quiz.nhn?action=userInfoPage";
	}
	
	public String deleteUser(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession(); 
		int user_no= (int)session.getAttribute("user_no");
		try {
			commentDao.delComment(user_no);
			userDao.delUser(user_no);
		} catch (SQLException e) {
			e.printStackTrace();
			ctx.log("사용자 삭제 과정에서 문제 발생!!");
			request.setAttribute("error", "사용자가 정상적으로 삭제되지 않았습니다!!");
			return myPage(request,response);
		}
		return "redirect:/quiz.nhn?action=loginPage";
	}
	
	public String updateUser(HttpServletRequest request,HttpServletResponse response) {
		UserDto u = new UserDto();
		HttpSession session = request.getSession(); 
		int user_no= (int)session.getAttribute("user_no");
		try {
			Part part = request.getPart("file");
			String fileName = getFilename(part);
			if(fileName != null && !fileName.isEmpty()){
			part.write(fileName);
			}
			BeanUtils.populate(u, request.getParameterMap());
			
			u.setUser_no(user_no);
			u.setImg("/img/"+fileName);
			
			userDao.updateUsers(u);
		} catch (Exception e) {
			e.printStackTrace();
			ctx.log("수정 과정에서 문제 발생!!");
			request.setAttribute("error", "정상적으로 수정되지 않았습니다!!");
			return myPage(request,response);
		}
		return "redirect:/quiz.nhn?action=myPage";	
	}
	private String getFilename(Part part) {
		String fileName = null;
		// 파일이름이 들어있는 헤더 영역을 가지고 옴
		 String header = part.getHeader("content-disposition");
		//part.getHeader -> form-data; name="img"; filename="사진5.jpg"
		System.out.println("Header => "+header);
		// 파일 이름이 들어있는 속성 부분의 시작위치를 가져와 쌍따옴표 사이의 값 부분만 가지고옴
		 int start = header.indexOf("filename=");
		fileName = header.substring(start+10,header.length()-1);
		ctx.log("파일명:"+fileName);
		return fileName;
	}
}
