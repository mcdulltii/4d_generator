################################################################################
#                            BASE IMAGE                                        #
################################################################################

FROM thevlang/vlang:buster AS base

RUN apt update
RUN apt install make -y

################################################################################
#                           BUILD STAGE                                        #
################################################################################

FROM base AS build

COPY src /build

WORKDIR /build

RUN make VCC=v

################################################################################
#                           EXPORT STAGE                                       #
################################################################################

FROM scratch AS export

COPY --from=build /build /build

################################################################################
#                          DEPLOYMENT STAGE                                    #
################################################################################

FROM base AS deploy

RUN useradd -m 4d

WORKDIR /home/4d

COPY --from=export /build .

RUN chmod -R 750 /home/4d
RUN chown -R root:4d /home/4d

USER 4d
EXPOSE 12345

ENTRYPOINT ./4d
