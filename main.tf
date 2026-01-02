# main.tf

# 1. VPC 생성 Virtual Private Cloud(가상 사설 클라우드)

resource "aws_vpc" "main_vpc" { # 리소스 선언, aws_vpc라는 타입의 리소스를 만들겠다고 선언하고, 테라폼 내부에서 부를 별명을 main_vpc라고 함
  cidr_block = "10.0.0.0/16"  # IP 주소 범위: 이 네트워크에서 사용할 IP 대역을 설정합니다.
  enable_dns_hostnames = true # DNS 호스트네임: VPC 내부의 인스턴스들이 퍼블릭 DNS 이름(예: ec2-52-xx...)을 가질 수 있게 허용합니다.
  enable_dns_support = true # DNS 지원: AWS에서 제공하는 DNS 서버를 사용하여 도메인 해석을 할 수 있게 합니다.

  tags = {
    Name = "portfolio-vpc" # 이름표: AWS 콘솔 화면에서 이 VPC의 '이름' 열에 표시될 텍스트를 지정합니다.
  }
}

# 2. Public Subnets 생성, 서브넷은 VPC라는 큰 운동장을 작은 구역으로 나눈 것입니다.
resource "aws_subnet" "public_subnet_1" { # 리소스 선언: aws_subnet 타입 리소스를 선언하고, 별명을 public_subnet_1로 정합니다.
  vpc_id = aws_vpc.main_vpc.id # 소속 지정: 위에서 만든 main_vpc 안에 이 서브넷을 넣겠다는 연결 고리입니다. (ID 값을 자동으로 가져옵니다.)
  cidr_block = "10.0.1.0/24" # IP 주소 범위: VPC 대역(10.0.0.0/16)의 일부를 떼어줍니다. (약 256개의 IP 사용 가능)
  availability_zone = "ap-northeast-2a" # 위치 설정: 서울 리전의 여러 데이터 센터 중 'a' 구역에 물리적으로 배치합니다
  map_public_ip_on_launch = true # 공인 IP 자동 할당: 이 옵션이 true여야 이곳에 생성되는 EC2가 외부와 통신 가능한 'Public' 서브넷이 됩니다.
  
  tags = {
    Name = "portfolio-public-subnet"
  }
}