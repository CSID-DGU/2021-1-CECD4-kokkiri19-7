import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.io.FileHandler;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class SeleniumTest {
 
    public static void main(String[] args) {
 
        SeleniumTest selTest = new SeleniumTest();
        //ConnectionTest();
        //selTest.screenshotTest();
        //selTest.getBanner();
        selTest.crawlJungguSaeng();
        //selTest.crawl_Junggu_Munhwa();
        //selTest.searchJunggu();
        
    }
    //WebDriver
    private WebDriver driver;
    
    //Properties
    public static final String WEB_DRIVER_ID = "webdriver.chrome.driver";
    //크롬 드라이버 경로
    public static final String WEB_DRIVER_PATH = "C:\\selenium-java-3.141.59\\chromedriver.exe";
    
    //크롤링 할 URL	
    private String base_url;
    
    public SeleniumTest() {
        super();
 
        //System Property SetUp
        System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);
        

    }
    
    public final static String INDENT = "  ";

    //json print 할 때 예쁘게 보이게 하기
    public static String jsonPretty( String jsonString )
    {
        final int length = jsonString.length( );
        StringBuilder sb = new StringBuilder( length + 200 );
        int indentDepth = 0;
        for ( int i = 0 , len = length ; i < len ; i++ )
        {
            String targetString = jsonString.substring( i , i + 1 );
            if ( targetString.equals( "{" ) || targetString.equals( "[" ) )
            {
                sb.append( targetString ).append( "\n" );
                indentDepth++;
                for ( int j = 0 ; j < indentDepth ; j++ )
                {
                    sb.append( INDENT );
                }
            }
            else if ( targetString.equals( "}" ) || targetString.equals( "]" ) )
            {
                sb.append( "\n" );
                indentDepth--;
                for ( int j = 0 ; j < indentDepth ; j++ )
                {
                    sb.append( INDENT );
                }
                sb.append( targetString );
            }
            else if ( targetString.equals( "," ) )
            {
                sb.append( targetString ).append( "\n" );
                for ( int j = 0 ; j < indentDepth ; j++ )
                {
                    sb.append( INDENT );
                }
            }
            else
            {
                sb.append( targetString );
            }
        }
        return sb.toString( );
    }
    public static String convertString(String val) {
    	// 변환할 문자를 저장할 버퍼 선언
    	StringBuffer sb = new StringBuffer();
    	// 글자를 하나하나 탐색한다.
    	for (int i = 0; i < val.length(); i++) {
    	if ('\\' == val.charAt(i) && 'u' == val.charAt(i + 1)) {
    	Character r = (char) Integer.parseInt(val.substring(i + 2, i + 6), 16);
    	// 변환된 글자를 버퍼에 넣는다.
    	sb.append(r);
    	// for의 증가 값 1과 5를 합해 6글자를 점프
    	i += 5;
    	} else {
    	sb.append(val.charAt(i));
    	}
    	}
    	// 결과 리턴
    	return sb.toString();
    }
    public static void ConnectionTest() {
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try{
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost/o_bok";

                // @param  getConnection(url, userName, password);
                // @return Connection
                conn = DriverManager.getConnection(url, "root", "1234");
                System.out.println("연결 성공");
                stmt = conn.createStatement();
                String sql = "select nickName, email from people";
                rs = stmt.executeQuery(sql);

                while(rs.next()){
                String nickName = rs.getString(1);
                String email = rs.getString(2);
                
                System.out.println(nickName + " " + email + " ");
                }
            }
            catch(ClassNotFoundException e){
                System.out.println("드라이버 로딩 실패");
            }
            catch(SQLException e){
                System.out.println("에러: " + e);
            }
            try{
                if( conn != null && !conn.isClosed()){
                    conn.close();
                }
                if( stmt != null && !stmt.isClosed()){
                    stmt.close();
                }
                if( rs != null && !rs.isClosed()){
                    rs.close();
                }
            }
            catch( SQLException e){
                e.printStackTrace();
                }
            }
    
    public void screenshotTest() {
    	driver = new ChromeDriver();
    	try {
        	base_url = "링크";
        	List<WebElement> el1 = driver.findElements(By.className("태그 이름"));
            
            for (int j = 2; j < el1.size(); j++) { //정부 24의 배너는 4개인 경우 앞에 두개를 배너 갯수, 현재 배너를 표기하기 위한 2개를 넣어 6개이다. 
            	WebElement el2 = el1.get(j);
            	WebElement el3 = el2.findElement(By.className("pc-img"));
                File scrFile= el3.getScreenshotAs(OutputType.FILE);
                File destfile= new File("C:\\Users\\sunwo\\Desktop\\screenshot\\screenshot" + (j-2) + ".png");
                FileHandler.copy(scrFile, destfile);
            }
      
            //전체 페이지 스크린샷
            
            File scrFile= ((TakesScreenshot)driver).getScreenshotAs(OutputType.FILE);
            File destfile= new File("C:\\Users\\sunwo\\Desktop\\screenshot.png");
            FileHandler.copy(scrFile, destfile);
    	} catch (Exception e) {
            
            e.printStackTrace();
        
        } finally {
 
            driver.close();
        }
 
    }
    
    public void getBanner() {
        //Driver SetUp
        driver = new ChromeDriver();
        base_url = "https://www.gov.kr/portal/main#none";
        try {
            driver.get(base_url);
            JSONObject jsonObject = new JSONObject();
            JSONObject bannerInfo = new JSONObject();
            JSONArray bannerArray = new JSONArray();
            
            List<WebElement> el1 = driver.findElements(By.cssSelector(".visual-banner-list>.item.swiper-slide"));
            for (int j = 2; j < el1.size(); j++) { //정부 24의 배너 개수는 4개인 경우 앞에 두개를 배너 갯수, 현재 배너를 표기하기 위한 2개를 넣어 6개이다. 
            	WebElement el2 = el1.get(j);
            	WebElement el3 = el2.findElement(By.className("pc-img"));
            	WebElement el4 = el2.findElement(By.cssSelector("a"));
            	String url = el4.getAttribute("href");
            	String images = el3.getAttribute("src");
            	bannerInfo.put("address", url);
            	bannerInfo.put("picture", images);
            	System.out.println(url);
            	System.out.println(images);
            	if(j!=el1.size()-1) {
            		bannerInfo = new JSONObject();
            	}
            	bannerArray.add(bannerInfo);
            }
            jsonObject.put("BANNER",bannerArray);
            String jsonInfo = jsonObject.toJSONString();
            System.out.print(jsonInfo);
        } catch (Exception e) {
            
            e.printStackTrace();
        
        } finally {
 
            driver.close();
        }
 
    }
    
	public void crawlJungguSaeng() { //클릭 안하고 display:none인 텍스트 크롤링
        //Driver SetUp
        driver = new ChromeDriver();
        String[] base_url= { 
        "http://www.junggu.seoul.kr/content.do?cmsid=14386&sf_text4=B", //임신,출산
         "http://www.junggu.seoul.kr/content.do?cmsid=14386&sf_text4=E", //청년
         "http://www.junggu.seoul.kr/content.do?cmsid=14386&sf_text4=C", //영유아
         "http://www.junggu.seoul.kr/content.do?cmsid=14386&sf_text4=D", //아동,청소년
         "http://www.junggu.seoul.kr/content.do?cmsid=14386&sf_text4=E", //청년
         "http://www.junggu.seoul.kr/content.do?cmsid=14386&sf_text4=F", //중장년
         "http://www.junggu.seoul.kr/content.do?cmsid=14386&sf_text4=G", //어르신
         "http://www.junggu.seoul.kr/content.do?cmsid=14386&sf_text4=I", //장애인
         "http://www.junggu.seoul.kr/content.do?cmsid=14386&sf_text4=H" }; //전 생애주기
        try {
        	for(int kinds = 0; kinds<9; kinds++) {
        		driver.get(base_url[kinds]);
                
                JSONObject jsonObject = new JSONObject();
                JSONArray saengArray = new JSONArray();
                
                
                List<WebElement> el1 = driver.findElements(By.className("welfare_tit"));
                List<WebElement> el3 = driver.findElements(By.className("welfare_bottom"));
                String title ="";
                String[] classification = {"임신,출산", "청년", "영유아", "아동,청소년", "청년", "중장년", "어르신", "장애인", "전 생애주기"};
                String content = "";
                String summary = "";
                String url = "";
                String site = "중구";
                for(int i =0; i< el1.size(); i++) {
                	WebElement el2 = el1.get(i);
                	el2.click();
                	Thread.sleep(100);
                	WebElement el4 = el3.get(i);
                	List<WebElement> titleEls = el4.findElements(By.cssSelector("dt"));
                	List<WebElement> contentEls = el4.findElements(By.cssSelector("dd"));
                	JSONObject saengInfo = new JSONObject();
                	for(int j=0; j< titleEls.size(); j++) {
                		String titleEl = titleEls.get(j).getAttribute("textContent");
                		String contentEl = contentEls.get(j).getAttribute("textContent");
                		contentEl = contentEl.replace("\n", "");
                		contentEl = convertString(contentEl);
                		if(titleEl.equals("연결 사이트")) {
                			WebElement contentLink = el4.findElement(By.cssSelector("a"));
                			url = contentLink.getAttribute("href");
                			break;
                		}
                		if(j==0) {
                			saengInfo.put("title", contentEl);
                		}
                		else {
                			if(titleEl.equals("지원내용")) {
                				String sum = titleEl + ": " + contentEl;
                				summary += sum;
                			}
                			else if(titleEl.equals("지원내용")) {
                				continue;
                			}
                			String body = titleEl + ": " + contentEl;
                			body.replaceAll("\\\\r\\\\n", "");
                			body.replaceAll("\\r\\n", "");
                			body.replaceAll("\r\n", "");
                			body.replaceAll("\n", "");
                			content += body;
                		}
                	}
                	saengInfo.put("classification", classification[kinds]);
                	saengInfo.put("content", content);
                	saengInfo.put("url", url);
                	saengInfo.put("site", site);
                	saengInfo.put("summary", summary);
                	saengArray.add(saengInfo);
                	saengInfo = new JSONObject();
                	title ="";
                    content = "";
                    summary = "";
                    url = "";
                    site = "중구";
                }
                jsonObject.put("SAENG", saengArray);
                String jsonInfo = jsonObject.toJSONString();
                System.out.print(jsonPretty(jsonInfo));
                try (FileWriter file = new FileWriter("saeng.json")) {
                    file.write(saengArray.toJSONString()); 
                    file.flush();
         
                } catch (IOException e) {
                    e.printStackTrace();
                }
        	}
            
        } catch (Exception e) {
            
            e.printStackTrace();
        
        } finally {
 
            driver.close();
        }
    }
    
    public void crawl_Junggu_Munhwa() {
        //Driver SetUp
        driver = new ChromeDriver();
        base_url = "http://www.junggu.seoul.kr/tour/content.do?cmsid=14987";

        try {
            driver.get(base_url);
            List<WebElement> page = driver.findElements(By.cssSelector("#contents > div > div > ul > li"));
            
            JSONObject jsonObject = new JSONObject();
            JSONArray munhwaArray = new JSONArray();
            
            
            String title ="";
            String classification = "문화";
            String content = "";
            String url = "";
            String site = "중구";
            String summary = "";
            
            for(int i = 0; i < page.size(); i++) {
            	WebElement currentPost = driver.findElement(By.cssSelector("#contents > div > ul"));
            	List<WebElement> post = currentPost.findElements(By.tagName("li"));
            	for(int j = 0; j < post.size(); j++) {
            		JSONObject munhwaInfo = new JSONObject();
            		WebElement el3 = post.get(j).findElement(By.cssSelector("a"));
            		String el4 = el3.getAttribute("href");
            		url = el4;
            		((JavascriptExecutor) driver).executeScript("window.open()");
            		ArrayList<String> tabs = new ArrayList<String>(driver.getWindowHandles());
            		driver.switchTo().window(tabs.get(1)).navigate().to(el4);
                    
            		WebElement contentTitle = driver.findElement(By.cssSelector("#contents > div.imgType_view_title1 > h2"));
            		title = contentTitle.getText();
            		munhwaInfo.put("title", title);
                    List<WebElement> infoContent = driver.findElement(By.className("info_list")).findElements(By.cssSelector("li"));
                    WebElement infoTitle = driver.findElement(By.className("info_title"));
                    for(int k =0; k<infoContent.size(); k++) {
                    	WebElement titleEl = infoContent.get(k).findElement(By.cssSelector("h5"));
                    	String titleElst = titleEl.getText();
                    	WebElement contentEl = infoContent.get(k).findElement(By.cssSelector("p"));
                    	String contentElst = contentEl.getText();
                    	if(titleElst.equals("홈페이지")) {
                    		continue;
                    	}
                    	String body = titleElst + ": " + contentElst;
                    	body = body.replace("\u2018", "'").replace("\u2019", "'");
                    	content += body;
                    	summary += body;
                    }
                    content += infoTitle.getText();
                    summary += infoTitle.getText();
                    munhwaInfo.put("classification", classification);
                    munhwaInfo.put("content", content);
                    munhwaInfo.put("url", url);
                    munhwaInfo.put("site", site);
                    munhwaArray.add(munhwaInfo);
                    title ="";
                    classification = "문화";
                    content = "";
                    url = "";
                    site = "중구";
                    summary = "";
                    driver.close();
                    driver.switchTo().window(tabs.get(0));
            	}
            	if(i<page.size()-1)
            	{
            		WebElement currentPage = page.get(i+1);
            		currentPage.click();
            	}
            	
            }
            jsonObject.put("MUNHWA", munhwaArray);
            String jsonInfo = jsonObject.toJSONString();
            System.out.print(jsonPretty(jsonInfo));
            try (FileWriter file = new FileWriter("munhwa.json")) {
                file.write(munhwaArray.toJSONString()); 
                file.flush();
     
            } catch (IOException e) {
                e.printStackTrace();
            }
    
        } catch (Exception e) {
            
            e.printStackTrace();
        
        } finally {
 
            driver.close();
        }
    }
    
    public void searchJunggu() {
        //Driver SetUp
        driver = new ChromeDriver();
        base_url = "http://www.junggu.seoul.kr/main.do";
        try {
            driver.get(base_url);
            
            WebElement el1 = driver.findElement(By.className("search_m_input"));
            String search ="소상공인";
            el1.sendKeys(search);
            el1 = driver.findElement(By.className("btn_m_search"));
            el1.click();
            
            
            WebElement el2 = driver.findElement(By.className("meu_txt2"));
            List<WebElement> menuEl = el2.findElements(By.cssSelector("li"));
            int count = menuEl.size();
           
            for(int i = 0; i < count; i++) {
            	int k = i+1;
                WebElement el3 = el2.findElement(By.cssSelector("li:nth-child("+ k +")"));
                el3.click();
                
                //탭 전환
                ArrayList<String> tabs2 = new ArrayList<String>(driver.getWindowHandles());
                driver.switchTo().window(tabs2.get(1));
                
                WebElement el4 = driver.findElement(By.className("content"));
                System.out.println(el4.getText());
                System.out.println("--------------------------------------------------------------------------------------------------------------------------------------------");
                driver.close();
                driver.switchTo().window(tabs2.get(0));
            }

            
        } catch (Exception e) {
            
            e.printStackTrace();
        
        } finally {
 
            driver.quit();

        }
 
    }
 
}
