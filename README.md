# 실행환경


## 1. Docker

### 1단계: 이미지 빌드 (Build)
먼저 Dockerfile과 environment.yml이 있는 곳에서 터미널을 열고, 빌드 명령어를 실행하세요. 이미지 이름을 my-jupyter-app이라고 하겠습니다.

```bash
docker build -t my-jupyter-app .
```
이 명령어가 environment.yml을 읽어서 jupyter, pandas 등이 설치된 myenv 환경을 만듭니다.

### 2단계: 컨테이너 실행 (Run)
이제 1단계에서 만든 my-jupyter-app 이미지를 실행해야 합니다. (윈도우 CMD 기준입니다.)

```bash
docker run -d --rm -p 8888:8888 -v //d/conda:/app --name my-notebook my-jupyter-app
```

1. docker run -d ...: 컨테이너를 백그라운드에서 실행합니다.
1. -p 8888:8888: Dockerfile에서 설정한 Jupyter 포트 8888번을 엽니다.
1. -v //d/conda:/app: (중요) 현재 로컬 디렉토리(노트북 파일이 있는 곳)를 컨테이너의 /app 폴더에 연결합니다.
1. --name my-notebook: 컨테이너 이름을 my-notebook으로 지정합니다. (기존 my-photo-task와 겹치지 않게)
1. my-jupyter-app: continuumio/miniconda3:latest가 아니라 1번에서 빌드한 내 이미지 이름을 사용합니다.
1. sleep infinity가 필요 없습니다. Dockerfile의 CMD가 알아서 Jupyter를 실행합니다.

### 3단계: Docker 에서 .ipynb 실행

1. conda 환경은 base 연결

