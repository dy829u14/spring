package come.packt.cardatabase;

import java.util.Arrays;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import come.packt.cardatabase.domain.Car;
import come.packt.cardatabase.domain.CarRepository;
import come.packt.cardatabase.domain.Owner;
import come.packt.cardatabase.domain.OwnerRepository;
import come.packt.cardatabase.domain.User;
import come.packt.cardatabase.domain.UserRepository;

//@EnableAutoConfiguration : 스프링부트 자동 구성을 활성화
//@ComponentScan : 스프링부트 컴포넌트 검색으로 애플리케이션의 컴포넌트를 찾음
//@Configuration : 빈(bean)정의의 원본으로 쓸수있는 클래스임을 정의
//위 3개의 어노테이션 조합
@SpringBootApplication
public class CardatabaseApplication implements CommandLineRunner {
	private static final Logger logger = LoggerFactory.getLogger(CardatabaseApplication.class);
	//의존성 주입
	@Autowired
	private CarRepository repository;
	
	@Autowired
	private OwnerRepository orepository;
	
	@Autowired
	private UserRepository urepository;
	
	private BCryptPasswordEncoder pwencoder = new BCryptPasswordEncoder();
	
	public static void main(String[] args) {
		//코드를 추가하면 애플리케이션이 재시작됨
		SpringApplication.run(CardatabaseApplication.class, args);
		logger.info("어플 시작");
	}
	@Override
	public void run(String... args) throws Exception {
		Owner owner1 = new Owner("그린", "김");
		Owner owner2 = new Owner("길동", "홍");
		Owner owner3 = new Owner("지아", "박");
		//insert saveAll : 여러데이터 저장
		orepository.saveAll(Arrays.asList(owner1, owner2, owner3));
		repository.save(new Car("Ford", "Mustang","red","ADF-1121",2021,59000, owner1));
		repository.save(new Car("Nissan", "Leaf","white","SSJ-1122",2020,21000, owner2));
		repository.save(new Car("Toyota", "Prius","black","KKO-1321",2022,34000, owner3));
		repository.save(new Car("현대", "소나타","black","KKO-1321",2022,34000, owner3));
		repository.save(new Car("기아", "K5","black","KKO-1321",2022,34000, owner3));
		
		//모든 레코드를 가지고와서 콘솔에 로깅
		for(Car car: repository.findByBrand("현대")) {
			logger.info(car.getBrand()+" "+car.getModel());
		}
		
		
		//사용자이름 user 암호 user
		urepository.save(new User("user",pwencoder.encode("user"),"USER"));
		urepository.save(new User("admin",pwencoder.encode("admin"),"ADMIN"));
		
			
	}
	

}
