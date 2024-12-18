package quiz;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Method;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/quiz.nhn")
public class QuizController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private ChatBotService chatBotService;
	private QuizService quizService;
	private GameLogService gameLogService;
	private ServletContext ctx;

	// 웹 리소스 기본 경로 지정
	private final String START_PAGE = "user/login.jsp";
	
	public void init(ServletConfig config) throws ServletException {

		super.init(config);
		ctx = getServletContext();
		chatBotService = new ChatBotService();
		quizService = new QuizService();
		gameLogService = new GameLogService();
		
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
		
		HttpSession session = request.getSession();
		int userNo = Integer.parseInt(session.getAttribute("userNo").toString()) ;
		gameLogService.saveGameLog(userNo, correctCnt);
		
		System.out.println(userNo);
		
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
		
		return "user/userInfoView.jsp";
	}
}
