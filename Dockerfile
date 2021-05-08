# a partir de qual imagem ira ser construida
FROM golang:latest as go_image_build
WORKDIR /go/src
COPY . . 
RUN GOOS=linux go build main.go

# usa a imagem scratch que é uma bem leve que a golang image
FROM scratch

# define diretório de trabalho da imagem scratch
WORKDIR /go/src

# copia do diretorio de trabalho da imagem go_image_build para a da scratch
COPY --from=go_image_build /go/src/main .

# executa o arquivo do diretorio de trabalho da imagem scratc
CMD ["./main"]