From: p.sawicki2@partner.samsung.com (Piotr Sawicki)
Date: Fri, 3 Aug 2018 11:10:09 +0200
Subject: [PATCH v1 20/22] Move common usercopy into
	security_getpeersec_stream
In-Reply-To: <ac4a4408-5c69-4b87-b57d-537dba588b18@schaufler-ca.com>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
	<ac4a4408-5c69-4b87-b57d-537dba588b18@schaufler-ca.com>
	<CGME20180803091011eucas1p29e46a12d1986f11e63547ea1ec8e8663@eucas1p2.samsung.com>
Message-ID: <20180803091011eucas1p29e46a12d1986f11e63547ea1ec8e8663~HVMbjcXDZ2739127391eucas1p2M@eucas1p2.samsung.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 07/16/2018 08:24 PM, Casey Schaufler wrote:
> [PATCH 20/22] Move common usercopy into security_getpeersec_stream
> 
> The modules implementing hook for getpeersec_stream
> don't need to be duplicating the copy-to-user checks.
> Moving the user copy part into the infrastructure makes
> the security module code simpler and reduces the places
> where user copy code may go awry.

Hi,

This change will break the API. Some clients may call getsockopt(..,SO_PEERSEC,..) twice. Firstly, to fetch the length. In that case xxx_socket_getpeersec_stream should return -ERANGE and set *optlen. Secondly, to retrieve a proper security label.

Please take a look at the implementation of the getClientSmackLabel() function in Cynara: https://review.tizen.org/gerrit/#/c/26888/6/src/helpers/creds-socket/creds-socket-inner.cpp
Also there is an email thread about this socket option which tells us why it is made this way: "[RFC] SO_PEERSEC - security credentials for Unix stream sockets"

http://lists.jammed.com/linux-security-module/2003/12/0029.html

Regards,
Piotr
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
