Return-Path: <SRS0=MFhz=SN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B161C282CE
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Apr 2019 11:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF55217D4
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Apr 2019 11:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfDKLcC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:32:02 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54503 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfDKLcC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Apr 2019 07:32:02 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x3BBVplU031262;
        Thu, 11 Apr 2019 20:31:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Thu, 11 Apr 2019 20:31:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157095162.bbtec.net [60.157.95.162])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x3BBVl3H031012
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 11 Apr 2019 20:31:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] net: socket: Always initialize family field at
 move_addr_to_kernel().
To:     linux-security-module <linux-security-module@vger.kernel.org>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        syzbot+0049bebbf3042dbd2e8f@syzkaller.appspotmail.com,
        syzbot+915c9f99f3dbc4bd6cd1@syzkaller.appspotmail.com
References: <1554128362-12274-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190402.132306.2280596762532017665.davem@davemloft.net>
 <b4083428-53b2-0f71-585f-d648b8fd1331@i-love.sakura.ne.jp>
 <20190403.214926.2003732231073495468.davem@davemloft.net>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <4d077355-03de-0b8a-b6fc-51757eafe7eb@i-love.sakura.ne.jp>
Date:   Thu, 11 Apr 2019 20:31:45 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403.214926.2003732231073495468.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019/04/04 13:49, David Miller wrote:
> From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Date: Wed, 3 Apr 2019 06:07:40 +0900
> 
>> On 2019/04/03 5:23, David Miller wrote:
>>> Please fix RDS and other protocols to examine the length properly
>>> instead.
>>
>> Do you prefer adding branches only for allow reading the family of socket address?
> 
> If the length is zero, there is no point in reading the family.
> 

(Adding LSM people.)

syzbot is reporting that RDS is not checking valid length of address given from userspace.
It turned out that there are several users who access "struct sockaddr"->family without
checking valid length (which will be reported by KMSAN).

Unfortunately, since tipc_bind() in net/tipc/socket.c accepts length == 0 as a valid input,
we can't reject length < offsetofend(struct sockaddr, sa_family) with -EINVAL at
move_addr_to_kernel() which are called from bind()/connect() system calls. I proposed
always setting "struct sockaddr"->family at move_addr_to_kernel() but David does not
like such trick.

Therefore, LSM modules which checks address and/or port have to check valid length
before accessing "struct sockaddr"->family in order to determine IPv4 or IPv6 or UNIX.

Below is all-in-one change (for x86_64 allmodconfig). Well, I've just realized that
move_addr_to_kernel() is also called by sendmsg() system call and for now added changes
for only security/ directory. Is this change appropriate for you? (I wish we could
simplify this by automatically initializing "struct sockaddr_storage" with 0 at
move_addr_to_kernel()...)
---
 drivers/isdn/mISDN/socket.c |  4 ++--
 net/bluetooth/sco.c         |  4 ++--
 net/core/filter.c           |  2 ++
 net/ipv6/udp.c              |  2 ++
 net/llc/af_llc.c            |  3 +--
 net/netlink/af_netlink.c    |  3 ++-
 net/rds/af_rds.c            |  3 +++
 net/rds/bind.c              |  2 ++
 net/rxrpc/af_rxrpc.c        |  3 ++-
 net/sctp/socket.c           |  3 ++-
 security/apparmor/lsm.c     |  6 ++++++
 security/selinux/hooks.c    | 12 ++++++++++++
 security/smack/smack_lsm.c  | 39 +++++++++++++++++++++++++++++++++++----
 security/tomoyo/network.c   | 12 ++++++++++++
 14 files changed, 85 insertions(+), 13 deletions(-)

diff --git a/drivers/isdn/mISDN/socket.c b/drivers/isdn/mISDN/socket.c
index 4ab8b1b..a14e35d 100644
--- a/drivers/isdn/mISDN/socket.c
+++ b/drivers/isdn/mISDN/socket.c
@@ -710,10 +710,10 @@ static int data_sock_getsockopt(struct socket *sock, int level, int optname,
 	struct sock *sk = sock->sk;
 	int err = 0;
 
-	if (!maddr || maddr->family != AF_ISDN)
+	if (addr_len < sizeof(struct sockaddr_mISDN))
 		return -EINVAL;
 
-	if (addr_len < sizeof(struct sockaddr_mISDN))
+	if (!maddr || maddr->family != AF_ISDN)
 		return -EINVAL;
 
 	lock_sock(sk);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 9a58099..d892b7c 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -523,12 +523,12 @@ static int sco_sock_bind(struct socket *sock, struct sockaddr *addr,
 	struct sock *sk = sock->sk;
 	int err = 0;
 
-	BT_DBG("sk %p %pMR", sk, &sa->sco_bdaddr);
-
 	if (!addr || addr_len < sizeof(struct sockaddr_sco) ||
 	    addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
 
+	BT_DBG("sk %p %pMR", sk, &sa->sco_bdaddr);
+
 	lock_sock(sk);
 
 	if (sk->sk_state != BT_OPEN) {
diff --git a/net/core/filter.c b/net/core/filter.c
index 41f633c..b9089fd 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4458,6 +4458,8 @@ static unsigned long bpf_xdp_copy(void *dst_buff, const void *src_buff,
 	 * Only binding to IP is supported.
 	 */
 	err = -EINVAL;
+	if (addr_len < offsetofend(struct sockaddr, sa_family))
+		return err;
 	if (addr->sa_family == AF_INET) {
 		if (addr_len < sizeof(struct sockaddr_in))
 			return err;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index d538faf..2464fba 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1045,6 +1045,8 @@ static void udp_v6_flush_pending_frames(struct sock *sk)
 static int udpv6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 			     int addr_len)
 {
+	if (addr_len < offsetofend(struct sockaddr, sa_family))
+		return -EINVAL;
 	/* The following checks are replicated from __ip6_datagram_connect()
 	 * and intended to prevent BPF program called below from accessing
 	 * bytes that are out of the bound specified by user in addr_len.
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index b99e73a..2017b7d 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -320,14 +320,13 @@ static int llc_ui_bind(struct socket *sock, struct sockaddr *uaddr, int addrlen)
 	struct llc_sap *sap;
 	int rc = -EINVAL;
 
-	dprintk("%s: binding %02X\n", __func__, addr->sllc_sap);
-
 	lock_sock(sk);
 	if (unlikely(!sock_flag(sk, SOCK_ZAPPED) || addrlen != sizeof(*addr)))
 		goto out;
 	rc = -EAFNOSUPPORT;
 	if (unlikely(addr->sllc_family != AF_LLC))
 		goto out;
+	dprintk("%s: binding %02X\n", __func__, addr->sllc_sap);
 	rc = -ENODEV;
 	rcu_read_lock();
 	if (sk->sk_bound_dev_if) {
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index f28e937..216ab91 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -988,7 +988,7 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
 	struct netlink_sock *nlk = nlk_sk(sk);
 	struct sockaddr_nl *nladdr = (struct sockaddr_nl *)addr;
 	int err = 0;
-	unsigned long groups = nladdr->nl_groups;
+	unsigned long groups;
 	bool bound;
 
 	if (addr_len < sizeof(struct sockaddr_nl))
@@ -996,6 +996,7 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
 
 	if (nladdr->nl_family != AF_NETLINK)
 		return -EINVAL;
+	groups = nladdr->nl_groups;
 
 	/* Only superuser is allowed to listen multicasts */
 	if (groups) {
diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index d6cc97f..2b969f9 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -543,6 +543,9 @@ static int rds_connect(struct socket *sock, struct sockaddr *uaddr,
 	struct rds_sock *rs = rds_sk_to_rs(sk);
 	int ret = 0;
 
+	if (addr_len < offsetofend(struct sockaddr, sa_family))
+		return -EINVAL;
+
 	lock_sock(sk);
 
 	switch (uaddr->sa_family) {
diff --git a/net/rds/bind.c b/net/rds/bind.c
index 17c9d9f..0f4398e 100644
--- a/net/rds/bind.c
+++ b/net/rds/bind.c
@@ -173,6 +173,8 @@ int rds_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	/* We allow an RDS socket to be bound to either IPv4 or IPv6
 	 * address.
 	 */
+	if (addr_len < offsetofend(struct sockaddr, sa_family))
+		return -EINVAL;
 	if (uaddr->sa_family == AF_INET) {
 		struct sockaddr_in *sin = (struct sockaddr_in *)uaddr;
 
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 96f2952..c54dce3 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -135,7 +135,7 @@ static int rxrpc_bind(struct socket *sock, struct sockaddr *saddr, int len)
 	struct sockaddr_rxrpc *srx = (struct sockaddr_rxrpc *)saddr;
 	struct rxrpc_local *local;
 	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
-	u16 service_id = srx->srx_service;
+	u16 service_id;
 	int ret;
 
 	_enter("%p,%p,%d", rx, saddr, len);
@@ -143,6 +143,7 @@ static int rxrpc_bind(struct socket *sock, struct sockaddr *saddr, int len)
 	ret = rxrpc_validate_address(rx, srx, len);
 	if (ret < 0)
 		goto error;
+	service_id = srx->srx_service;
 
 	lock_sock(&rx->sk);
 
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 9874e60..4583fa9 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4847,7 +4847,8 @@ static int sctp_connect(struct sock *sk, struct sockaddr *addr,
 	}
 
 	/* Validate addr_len before calling common connect/connectx routine. */
-	af = sctp_get_af_specific(addr->sa_family);
+	af = addr_len < offsetofend(struct sockaddr, sa_family) ? NULL :
+		sctp_get_af_specific(addr->sa_family);
 	if (!af || addr_len < af->sockaddr_len) {
 		err = -EINVAL;
 	} else {
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index e338359..e8b2163 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -866,6 +866,7 @@ static int apparmor_socket_bind(struct socket *sock,
 	AA_BUG(!address);
 	AA_BUG(in_interrupt());
 
+	/* No need to check addrlen because bind_perm() is not evaluated. */
 	return af_select(sock->sk->sk_family,
 			 bind_perm(sock, address, addrlen),
 			 aa_sk_perm(OP_BIND, AA_MAY_BIND, sock->sk));
@@ -882,6 +883,7 @@ static int apparmor_socket_connect(struct socket *sock,
 	AA_BUG(!address);
 	AA_BUG(in_interrupt());
 
+	/* No need to check addrlen because connect_perm() is not evaluated. */
 	return af_select(sock->sk->sk_family,
 			 connect_perm(sock, address, addrlen),
 			 aa_sk_perm(OP_CONNECT, AA_MAY_CONNECT, sock->sk));
@@ -927,6 +929,10 @@ static int aa_sock_msg_perm(const char *op, u32 request, struct socket *sock,
 	AA_BUG(!msg);
 	AA_BUG(in_interrupt());
 
+	/*
+	 * No need to check msg->msg_namelen because msg_perm() is not
+	 * evaluated.
+	 */
 	return af_select(sock->sk->sk_family,
 			 msg_perm(op, request, sock, msg, size),
 			 aa_sk_perm(op, request, sock->sk));
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d5fdcb0..710d386 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4503,6 +4503,12 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 	err = sock_has_perm(sk, SOCKET__BIND);
 	if (err)
 		goto out;
+	/*
+	 * Nothing more to do if valid length is too short to check
+	 * address->sa_family.
+	 */
+	if (addrlen < offsetofend(struct sockaddr, sa_family))
+		goto out;
 
 	/* If PF_INET or PF_INET6, check name_bind permission for the port. */
 	family = sk->sk_family;
@@ -4634,6 +4640,12 @@ static int selinux_socket_connect_helper(struct socket *sock,
 	err = sock_has_perm(sk, SOCKET__CONNECT);
 	if (err)
 		return err;
+	/*
+	 * Nothing more to do if valid length is too short to check
+	 * address->sa_family.
+	 */
+	if (addrlen < offsetofend(struct sockaddr, sa_family))
+		return 0;
 
 	/*
 	 * If a TCP, DCCP or SCTP socket, check name_connect permission
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 5c16135..7c19c04 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2805,13 +2805,21 @@ static int smack_socket_socketpair(struct socket *socka,
  *
  * Records the label bound to a port.
  *
- * Returns 0
+ * Returns 0 on success, and error code otherwise
  */
 static int smack_socket_bind(struct socket *sock, struct sockaddr *address,
 				int addrlen)
 {
-	if (sock->sk != NULL && sock->sk->sk_family == PF_INET6)
+	if (sock->sk != NULL && sock->sk->sk_family == PF_INET6) {
+		/*
+		 * Reject if valid length is too short for IPv6 address or
+		 * address family is not IPv6.
+		 */
+		if (addr_len < SIN6_LEN_RFC2133 ||
+		    address->sa_family != AF_INET6)
+			return -EINVAL;
 		smk_ipv6_port_label(sock, address);
+	}
 	return 0;
 }
 #endif /* SMACK_IPV6_PORT_LABELING */
@@ -2847,12 +2855,21 @@ static int smack_socket_connect(struct socket *sock, struct sockaddr *sap,
 
 	switch (sock->sk->sk_family) {
 	case PF_INET:
-		if (addrlen < sizeof(struct sockaddr_in))
+		/*
+		 * Reject if valid length is too short for IPv4 address or
+		 * address family is not IPv4.
+		 */
+		if (addrlen < sizeof(struct sockaddr_in) ||
+		    sap->sa_family != AF_INET)
 			return -EINVAL;
 		rc = smack_netlabel_send(sock->sk, (struct sockaddr_in *)sap);
 		break;
 	case PF_INET6:
-		if (addrlen < sizeof(struct sockaddr_in6))
+		/*
+		 * Reject if valid length is too short for IPv6 address or
+		 * address family is not IPv6.
+		 */
+		if (addrlen < SIN6_LEN_RFC2133 || sap->sa_family != AF_INET6)
 			return -EINVAL;
 #ifdef SMACK_IPV6_SECMARK_LABELING
 		rsp = smack_ipv6host_label(sip);
@@ -3682,9 +3699,23 @@ static int smack_socket_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	switch (sock->sk->sk_family) {
 	case AF_INET:
+		/*
+		 * Reject if valid length is too short for IPv4 address or
+		 * address family is not IPv4.
+		 */
+		if (msg->msg_namelen < sizeof(struct sockaddr_in) ||
+		    sip->sin_family != AF_INET)
+			return -EINVAL;
 		rc = smack_netlabel_send(sock->sk, sip);
 		break;
 	case AF_INET6:
+		/*
+		 * Reject if valid length is too short for IPv6 address or
+		 * address family is not IPv6.
+		 */
+		if (msg->msg_namelen < SIN6_LEN_RFC2133 ||
+		    sap->sin6_family != AF_INET6)
+			return -EINVAL;
 #ifdef SMACK_IPV6_SECMARK_LABELING
 		rsp = smack_ipv6host_label(sap);
 		if (rsp != NULL)
diff --git a/security/tomoyo/network.c b/security/tomoyo/network.c
index 9094f4b..3cbd6bd 100644
--- a/security/tomoyo/network.c
+++ b/security/tomoyo/network.c
@@ -505,6 +505,12 @@ static int tomoyo_check_inet_address(const struct sockaddr *addr,
 {
 	struct tomoyo_inet_addr_info *i = &address->inet;
 
+	/*
+	 * Nothing more to do if valid length is too short to check
+	 * address->sa_family.
+	 */
+	if (addr_len < offsetofend(struct sockaddr, sa_family))
+		return 0;
 	switch (addr->sa_family) {
 	case AF_INET6:
 		if (addr_len < SIN6_LEN_RFC2133)
@@ -594,6 +600,12 @@ static int tomoyo_check_unix_address(struct sockaddr *addr,
 {
 	struct tomoyo_unix_addr_info *u = &address->unix0;
 
+	/*
+	 * Nothing more to do if valid length is too short to check
+	 * address->sa_family.
+	 */
+	if (addr_len < offsetofend(struct sockaddr, sa_family))
+		return 0;
 	if (addr->sa_family != AF_UNIX)
 		return 0;
 	u->addr = ((struct sockaddr_un *) addr)->sun_path;
-- 
1.8.3.1
