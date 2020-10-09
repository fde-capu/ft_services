# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fde-capu <fde-capu@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/10/09 17:29:27 by fde-capu          #+#    #+#              #
#    Updated: 2020/10/09 19:43:56 by fde-capu         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM		alpine
LABEL		maintainer=fde-capu

RUN			apk update 

COPY		srcs/setup.sh /
ENTRYPOINT	["sh", "/setup.sh"]
