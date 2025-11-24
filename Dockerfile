# 1. Miniconda 공식 이미지를 기반으로 시작합니다.
FROM continuumio/miniconda3:latest

# 2. 작업 디렉토리를 /app 으로 설정합니다.
WORKDIR /app

# 3. 먼저 environment.yml 파일을 복사합니다.
COPY environment.yml .

# 4. 복사한 yml 파일로 conda 환경을 생성합니다. (시간이 다소 걸릴 수 있습니다)
#    환경 이름은 environment.yml 에 정의된 'myenv' 입니다.
RUN conda env create -f environment.yml

# 5. 나머지 모든 프로젝트 파일(.ipynb 등)을 컨테이너 내부로 복사합니다.
COPY . .

# 6. 컨테이너가 실행될 때 Jupyter 서버를 시작합니다.
#    --ip=0.0.0.0: 모든 IP에서의 접속 허용
#    --allow-root: 루트 계정으로 실행 허용
#    --no-browser: 브라우저 자동 실행 방지
#    --NotebookApp.token='': 접속 토큰(비밀번호) 비활성화 (보안상 로컬에서만 사용)
CMD ["/opt/conda/envs/myenv/bin/jupyter", "notebook", \
     "--ip=0.0.0.0", "--port=8888", "--allow-root", \
     "--no-browser", "--NotebookApp.token=''"]