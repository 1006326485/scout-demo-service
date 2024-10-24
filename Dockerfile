FROM ubuntu:22.04

ENV BLUEBIRD_WARNINGS=0 \
  NODE_ENV=production \
  NODE_NO_WARNINGS=1 \
  NPM_CONFIG_LOGLEVEL=warn \
  SUPPRESS_NO_CONFIG_WARNING=true

COPY package.json ./

# 更新系统并安装必要的工具
RUN apt-get update && apt-get install -y \
  curl \
  gnupg

# 添加 Node.js 18.x 的官方源并安装 Node.js 18.19.0
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get install -y nodejs=18.19.0-1nodesource1

# 验证 Node.js 版本
RUN node -v

# 设定工作目录
WORKDIR /app

# 复制应用代码到容器中
COPY . /app

# 安装应用依赖
RUN npm install

# 容器启动时执行的命令
CMD ["npm", "start"]

EXPOSE 3000
