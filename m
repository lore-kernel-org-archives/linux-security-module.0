Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FBFC43462
	for <linux-security-module@archiver.kernel.org>; Fri, 16 Apr 2021 12:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 412B76117A
	for <linux-security-module@archiver.kernel.org>; Fri, 16 Apr 2021 12:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbhDPM3U (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 16 Apr 2021 08:29:20 -0400
Received: from mailomta18-re.btinternet.com ([213.120.69.111]:60384 "EHLO
        re-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243527AbhDPM3U (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 16 Apr 2021 08:29:20 -0400
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-047.btinternet.com with ESMTP
          id <20210416122854.PEFS28099.re-prd-fep-047.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
          Fri, 16 Apr 2021 13:28:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1618576134; 
        bh=oGwdww20lPkRlXZQIZge0EjDW+p1WNJJy58pUottT7U=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=V4GKZi4Nn8QVVHMAsucUIGQVcnDBbghUKcWbBobdp2jdMCVjaqwJZlhUYXAxW0WSwIZzf4r0aqp2ZEV4wsENuHcKhHKqNCuqDNfPIVG3p6uUlPVzxpMReot/RQfufXKSf3+U8x8JK+ACQBKY8s4bdYsdyJPepmgvWOJdeYp+NfOCSKXpmAGQ7/dCP6fgqu6g6dy6nwJjCPwFRBz4R62Z2OcCOfdWAbFs5o4R9JCRcCjgKYCYIqh9rs+dE9OwniUoYY8kegWKrF+67+7514mW0F2skQ7/gSEJdylWegGgJzEQomyqmGGmUepngAbZJk/9FClAS86sdv0q8rzmSQkudQ==
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 5ED9C0CC2F24872B
X-Originating-IP: [86.184.99.58]
X-OWM-Source-IP: 86.184.99.58 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrudelhedgheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeutddtleelheeugefgiefhiedtheeukeffveeitdffgeffieeugeeljeegvefgieenucfkphepkeeirddukeegrdelledrheeknecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudekgedrleelrdehkedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoegtrghsvgihsehstghhrghufhhlvghrqdgtrgdrtghomheqpdhrtghpthhtohepoegtohhrsggvtheslhifnhdrnhgvtheqpdhrtghpthhtohepoehjmhhorhhrihhssehnrghmvghirdhorhhgqedprhgtphhtthhopeeolhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghl
        rdhorhhgqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghrghgvsehhrghllhihnhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.184.99.58) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C0CC2F24872B; Fri, 16 Apr 2021 13:28:54 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 3/3] include/linux: Update LSM hook text part2
Date:   Fri, 16 Apr 2021 13:28:43 +0100
Message-Id: <20210416122843.4752-4-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416122843.4752-1-richard_c_haines@btinternet.com>
References: <20210416122843.4752-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

No hook definitions have been updated, only formatting to render
in kernel_docs.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 include/linux/lsm_hooks.h | 1192 +++++++++++++++++++++----------------
 1 file changed, 683 insertions(+), 509 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index b7fdab1e9..75f97c5b9 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -950,71 +950,79 @@
  *	* @sig contains the signal value.
  *	* @cred contains the cred of the process where the signal originated, or %NULL if the current task is the originator.
  *	* Return %0 if permission is granted.
- * @task_prctl:
+ *
+ * int task_prctl(int option, unsigned long arg2, unsigned long arg3, unsigned long arg4, unsigned long arg5)
  *	Check permission before performing a process control operation on the
  *	current process.
- *	@option contains the operation.
- *	@arg2 contains a argument.
- *	@arg3 contains a argument.
- *	@arg4 contains a argument.
- *	@arg5 contains a argument.
- *	Return -ENOSYS if no-one wanted to handle this op, any other value to
- *	cause prctl() to return immediately with that value.
- * @task_to_inode:
+ *
+ *	* @option contains the operation.
+ *	* @arg2 contains a argument.
+ *	* @arg3 contains a argument.
+ *	* @arg4 contains a argument.
+ *	* @arg5 contains a argument.
+ *	* Return %-ENOSYS if no-one wanted to handle this op, any other value to cause @prctl() to return immediately with that value.
+ *
+ * void task_to_inode(struct task_struct \*p, struct inode \*inode)
  *	Set the security attributes for an inode based on an associated task's
  *	security attributes, e.g. for /proc/pid inodes.
- *	@p contains the task_struct for the task.
- *	@inode contains the inode structure for the inode.
  *
- * Security hooks for Netlink messaging.
+ *	* @p contains the task_struct for the task.
+ *	* @inode contains the inode structure for the inode.
+ *
+ * **Security hooks for Netlink messaging:**
  *
- * @netlink_send:
+ * int netlink_send(struct sock \*sk, struct sk_buff \*skb)
  *	Save security information for a netlink message so that permission
  *	checking can be performed when the message is processed.  The security
- *	information can be saved using the eff_cap field of the
- *	netlink_skb_parms structure.  Also may be used to provide fine
+ *	information can be saved using the %eff_cap field of the
+ *	@netlink_skb_parms structure.  Also may be used to provide fine
  *	grained control over message transmission.
- *	@sk associated sock of task sending the message.
- *	@skb contains the sk_buff structure for the netlink message.
- *	Return 0 if the information was successfully saved and message
- *	is allowed to be transmitted.
  *
- * Security hooks for Unix domain networking.
+ *	* @sk associated sock of task sending the message.
+ *	* @skb contains the sk_buff structure for the netlink message.
+ *	* Return %0 if the information was successfully saved and message is allowed to be transmitted.
  *
- * @unix_stream_connect:
+ * **Security hooks for Unix domain networking:**
+ *
+ * int unix_stream_connect(struct sock \*sock, struct sock \*other, struct sock \*newsk)
  *	Check permissions before establishing a Unix domain stream connection
  *	between @sock and @other.
- *	@sock contains the sock structure.
- *	@other contains the peer sock structure.
- *	@newsk contains the new sock structure.
- *	Return 0 if permission is granted.
- * @unix_may_send:
+ *
+ *	* @sock contains the sock structure.
+ *	* @other contains the peer sock structure.
+ *	* @newsk contains the new sock structure.
+ *	* Return %0 if permission is granted.
+ *
+ * int unix_may_send(struct socket \*sock, struct socket \*other)
  *	Check permissions before connecting or sending datagrams from @sock to
  *	@other.
- *	@sock contains the socket structure.
- *	@other contains the peer socket structure.
- *	Return 0 if permission is granted.
  *
- * The @unix_stream_connect and @unix_may_send hooks were necessary because
+ *	* @sock contains the socket structure.
+ *	* @other contains the peer socket structure.
+ *	* Return %0 if permission is granted.
+ *
+ * The @unix_stream_connect() and @unix_may_send() hooks were necessary because
  * Linux provides an alternative to the conventional file name space for Unix
  * domain sockets.  Whereas binding and connecting to sockets in the file name
- * space is mediated by the typical file permissions (and caught by the mknod
- * and permission hooks in inode_security_ops), binding and connecting to
+ * space is mediated by the typical file permissions (and caught by the @mknod
+ * and permission hooks in @inode_security_ops()), binding and connecting to
  * sockets in the abstract name space is completely unmediated.  Sufficient
  * control of Unix domain sockets in the abstract name space isn't possible
  * using only the socket layer hooks, since we need to know the actual target
- * socket, which is not looked up until we are inside the af_unix code.
+ * socket, which is not looked up until we are inside the @af_unix code.
  *
- * Security hooks for socket operations.
+ * **Security hooks for socket operations:**
  *
- * @socket_create:
+ * int socket_create(int family, int type, int protocol, int kern)
  *	Check permissions prior to creating a new socket.
- *	@family contains the requested protocol family.
- *	@type contains the requested communications type.
- *	@protocol contains the requested protocol.
- *	@kern set to 1 if a kernel socket.
- *	Return 0 if permission is granted.
- * @socket_post_create:
+ *
+ *	* @family contains the requested protocol family.
+ *	* @type contains the requested communications type.
+ *	* @protocol contains the requested protocol.
+ *	* @kern set to %1 if a kernel socket.
+ *	* Return %0 if permission is granted.
+ *
+ * int socket_post_create(struct socket \*sock, int family, int type, int protocol, int kern)
  *	This hook allows a module to update or allocate a per-socket security
  *	structure. Note that the security field was not added directly to the
  *	socket structure, but rather, the socket security information is stored
@@ -1023,706 +1031,872 @@
  *	SOCK_INODE(sock)->i_security.  This hook may be used to update the
  *	SOCK_INODE(sock)->i_security field with additional information that
  *	wasn't available when the inode was allocated.
- *	@sock contains the newly created socket structure.
- *	@family contains the requested protocol family.
- *	@type contains the requested communications type.
- *	@protocol contains the requested protocol.
- *	@kern set to 1 if a kernel socket.
- * @socket_socketpair:
+ *
+ *	* @sock contains the newly created socket structure.
+ *	* @family contains the requested protocol family.
+ *	* @type contains the requested communications type.
+ *	* @protocol contains the requested protocol.
+ *	* @kern set to %1 if a kernel socket.
+ *
+ * int socket_socketpair(struct socket \*socka, struct socket \*sockb)
  *	Check permissions before creating a fresh pair of sockets.
- *	@socka contains the first socket structure.
- *	@sockb contains the second socket structure.
- *	Return 0 if permission is granted and the connection was established.
- * @socket_bind:
+ *
+ *	* @socka contains the first socket structure.
+ *	* @sockb contains the second socket structure.
+ *	* Return %0 if permission is granted and the connection was established.
+ *
+ * int socket_bind(struct socket \*sock, struct sockaddr \*address, int addrlen)
  *	Check permission before socket protocol layer bind operation is
  *	performed and the socket @sock is bound to the address specified in the
  *	@address parameter.
- *	@sock contains the socket structure.
- *	@address contains the address to bind to.
- *	@addrlen contains the length of address.
- *	Return 0 if permission is granted.
- * @socket_connect:
+ *
+ *	* @sock contains the socket structure.
+ *	* @address contains the address to bind to.
+ *	* @addrlen contains the length of address.
+ *	* Return %0 if permission is granted.
+ *
+ * int socket_connect(struct socket \*sock, struct sockaddr \*address, int addrlen)
  *	Check permission before socket protocol layer connect operation
  *	attempts to connect socket @sock to a remote address, @address.
- *	@sock contains the socket structure.
- *	@address contains the address of remote endpoint.
- *	@addrlen contains the length of address.
- *	Return 0 if permission is granted.
- * @socket_listen:
+ *
+ *	* @sock contains the socket structure.
+ *	* @address contains the address of remote endpoint.
+ *	* @addrlen contains the length of address.
+ *	* Return %0 if permission is granted.
+ *
+ * int socket_listen(struct socket \*sock, int backlog)
  *	Check permission before socket protocol layer listen operation.
- *	@sock contains the socket structure.
- *	@backlog contains the maximum length for the pending connection queue.
- *	Return 0 if permission is granted.
- * @socket_accept:
+ *
+ *	* @sock contains the socket structure.
+ *	* @backlog contains the maximum length for the pending connection queue.
+ *	* Return %0 if permission is granted.
+ *
+ * int socket_accept(struct socket \*sock, struct socket \*newsock)
  *	Check permission before accepting a new connection.  Note that the new
  *	socket, @newsock, has been created and some information copied to it,
  *	but the accept operation has not actually been performed.
- *	@sock contains the listening socket structure.
- *	@newsock contains the newly created server socket for connection.
- *	Return 0 if permission is granted.
- * @socket_sendmsg:
+ *
+ *	* @sock contains the listening socket structure.
+ *	* @newsock contains the newly created server socket for connection.
+ *	* Return %0 if permission is granted.
+ *
+ * int socket_sendmsg(struct socket \*sock, struct msghdr \*msg, int size)
  *	Check permission before transmitting a message to another socket.
- *	@sock contains the socket structure.
- *	@msg contains the message to be transmitted.
- *	@size contains the size of message.
- *	Return 0 if permission is granted.
- * @socket_recvmsg:
+ *
+ *	* @sock contains the socket structure.
+ *	* @msg contains the message to be transmitted.
+ *	* @size contains the size of message.
+ *	* Return %0 if permission is granted.
+ *
+ * int socket_recvmsg(struct socket \*sock, struct msghdr \*msg, int size, int flags)
  *	Check permission before receiving a message from a socket.
- *	@sock contains the socket structure.
- *	@msg contains the message structure.
- *	@size contains the size of message structure.
- *	@flags contains the operational flags.
- *	Return 0 if permission is granted.
- * @socket_getsockname:
+ *
+ *	* @sock contains the socket structure.
+ *	* @msg contains the message structure.
+ *	* @size contains the size of message structure.
+ *	* @flags contains the operational flags.
+ *	* Return %0 if permission is granted.
+ *
+ * int socket_getsockname(struct socket \*sock)
  *	Check permission before the local address (name) of the socket object
  *	@sock is retrieved.
- *	@sock contains the socket structure.
- *	Return 0 if permission is granted.
- * @socket_getpeername:
+ *
+ *	* @sock contains the socket structure.
+ *	* Return %0 if permission is granted.
+ *
+ * int socket_getpeername(struct socket \*sock)
  *	Check permission before the remote address (name) of a socket object
+ *
  *	@sock is retrieved.
  *	@sock contains the socket structure.
- *	Return 0 if permission is granted.
- * @socket_getsockopt:
+ *	Return %0 if permission is granted.
+ *
+ * int socket_getsockopt(struct socket \*sock, int level, int optname)
  *	Check permissions before retrieving the options associated with socket
  *	@sock.
- *	@sock contains the socket structure.
- *	@level contains the protocol level to retrieve option from.
- *	@optname contains the name of option to retrieve.
- *	Return 0 if permission is granted.
- * @socket_setsockopt:
+ *
+ *	* @sock contains the socket structure.
+ *	* @level contains the protocol level to retrieve option from.
+ *	* @optname contains the name of option to retrieve.
+ *	* Return %0 if permission is granted.
+ *
+ * int socket_setsockopt(struct socket \*sock, int level, int optname)
  *	Check permissions before setting the options associated with socket
+ *
  *	@sock.
  *	@sock contains the socket structure.
  *	@level contains the protocol level to set options for.
  *	@optname contains the name of the option to set.
- *	Return 0 if permission is granted.
- * @socket_shutdown:
+ *	Return %0 if permission is granted.
+ *
+ * int socket_shutdown(struct socket \*sock, int how)
  *	Checks permission before all or part of a connection on the socket
  *	@sock is shut down.
- *	@sock contains the socket structure.
- *	@how contains the flag indicating how future sends and receives
- *	are handled.
- *	Return 0 if permission is granted.
- * @socket_sock_rcv_skb:
+ *
+ *	* @sock contains the socket structure.
+ *	* @how contains the flag indicating how future sends and receives are handled.
+ *	* Return %0 if permission is granted.
+ *
+ * int socket_sock_rcv_skb(struct sock \*sk, struct sk_buff \*skb)
  *	Check permissions on incoming network packets.  This hook is distinct
  *	from Netfilter's IP input hooks since it is the first time that the
- *	incoming sk_buff @skb has been associated with a particular socket, @sk.
+ *	incoming @sk_buff @skb has been associated with a particular socket, @sk.
  *	Must not sleep inside this hook because some callers hold spinlocks.
- *	@sk contains the sock (not socket) associated with the incoming sk_buff.
- *	@skb contains the incoming network data.
- * @socket_getpeersec_stream:
+ *
+ *	* @sk contains the sock (not socket) associated with the incoming sk_buff.
+ *	* @skb contains the incoming network data.
+ *
+ * int socket_getpeersec_stream(struct socket \*sock, char __user \*optval, int __user \*optlen, unsigned len)
  *	This hook allows the security module to provide peer socket security
- *	state for unix or connected tcp sockets to userspace via getsockopt
- *	SO_GETPEERSEC.  For tcp sockets this can be meaningful if the
+ *	state for unix or connected tcp sockets to userspace via @getsockopt()
+ *	%SO_GETPEERSEC.  For tcp sockets this can be meaningful if the
  *	socket is associated with an ipsec SA.
- *	@sock is the local socket.
- *	@optval userspace memory where the security state is to be copied.
- *	@optlen userspace int where the module should copy the actual length
- *	of the security state.
- *	@len as input is the maximum length to copy to userspace provided
- *	by the caller.
- *	Return 0 if all is well, otherwise, typical getsockopt return
- *	values.
- * @socket_getpeersec_dgram:
+ *
+ *	* @sock is the local socket.
+ *	* @optval userspace memory where the security state is to be copied.
+ *	* @optlen userspace int where the module should copy the actual length of the security state.
+ *	* @len as input is the maximum length to copy to userspace provided by the caller.
+ *	* Return %0 if all is well, otherwise, typical @getsockopt() return values.
+ *
+ * int socket_getpeersec_dgram(struct socket \*sock, struct sk_buff \*skb, u32 \*secid)
  *	This hook allows the security module to provide peer socket security
  *	state for udp sockets on a per-packet basis to userspace via
- *	getsockopt SO_GETPEERSEC. The application must first have indicated
- *	the IP_PASSSEC option via getsockopt. It can then retrieve the
- *	security state returned by this hook for a packet via the SCM_SECURITY
+ *	getsockopt %SO_GETPEERSEC. The application must first have indicated
+ *	the %IP_PASSSEC option via @getsockopt(). It can then retrieve the
+ *	security state returned by this hook for a packet via the %SCM_SECURITY
  *	ancillary message type.
- *	@sock contains the peer socket. May be NULL.
- *	@skb is the sk_buff for the packet being queried. May be NULL.
- *	@secid pointer to store the secid of the packet.
- *	Return 0 on success, error on failure.
- * @sk_alloc_security:
- *	Allocate and attach a security structure to the sk->sk_security field,
+ *
+ *	* @sock contains the peer socket. May be %NULL.
+ *	* @skb is the @sk_buff for the packet being queried. May be %NULL.
+ *	* @secid pointer to store the @secid of the packet.
+ *	* Return %0 on success, error on failure.
+ *
+ * int sk_alloc_security(struct sock \*sk, int family, gfp_t priority)
+ *	Allocate and attach a security structure to the @sk->sk_security field,
  *	which is used to copy security attributes between local stream sockets.
- * @sk_free_security:
+ *
+ * void sk_free_security(struct sock \*sk)
  *	Deallocate security structure.
- * @sk_clone_security:
+ *
+ * void sk_clone_security(const struct sock \*sk, struct sock \*newsk)
  *	Clone/copy security structure.
- * @sk_getsecid:
+ *
+ * void sk_getsecid(struct sock \*sk, u32 \*secid)
  *	Retrieve the LSM-specific secid for the sock to enable caching
  *	of network authorizations.
- * @sock_graft:
+ *
+ * void sock_graft(struct sock \*sk, struct socket \*parent)
  *	Sets the socket's isec sid to the sock's sid.
- * @inet_conn_request:
+ *
+ * int inet_conn_request(const struct sock \*sk, struct sk_buff \*skb, struct request_sock \*req)
  *	Sets the openreq's sid to socket's sid with MLS portion taken
  *	from peer sid.
- * @inet_csk_clone:
+ *
+ * void inet_csk_clone(struct sock \*newsk, const struct request_sock \*req)
  *	Sets the new child socket's sid to the openreq sid.
- * @inet_conn_established:
+ *
+ * void inet_conn_established(struct sock \*sk, struct sk_buff \*skb)
  *	Sets the connection's peersid to the secmark on skb.
- * @secmark_relabel_packet:
+ *
+ * int secmark_relabel_packet(u32 secid)
  *	check if the process should be allowed to relabel packets to
- *	the given secid
- * @secmark_refcount_inc:
+ *	the given @secid
+ *
+ * void secmark_refcount_inc(void)
  *	tells the LSM to increment the number of secmark labeling rules loaded
- * @secmark_refcount_dec:
+ *
+ * void secmark_refcount_dec(void)
  *	tells the LSM to decrement the number of secmark labeling rules loaded
- * @req_classify_flow:
+ *
+ * void req_classify_flow(const struct request_sock \*req, struct flowi_common \*flic)
  *	Sets the flow's sid to the openreq sid.
- * @tun_dev_alloc_security:
+ *
+ * **Security hooks for TUN device:**
+ *
+ * int tun_dev_alloc_security(void \*\*security)
  *	This hook allows a module to allocate a security structure for a TUN
  *	device.
- *	@security pointer to a security structure pointer.
- *	Returns a zero on success, negative values on failure.
- * @tun_dev_free_security:
+ *
+ *	* @security pointer to a security structure pointer.
+ *	* Returns a zero on success, negative values on failure.
+ *
+ * void tun_dev_free_security(void \*security)
  *	This hook allows a module to free the security structure for a TUN
  *	device.
- *	@security pointer to the TUN device's security structure
- * @tun_dev_create:
+ *
+ *	* @security pointer to the TUN device's security structure
+ *
+ * int tun_dev_create(void)
  *	Check permissions prior to creating a new TUN device.
- * @tun_dev_attach_queue:
+ *
+ * int tun_dev_attach_queue(void \*security)
  *	Check permissions prior to attaching to a TUN device queue.
- *	@security pointer to the TUN device's security structure.
- * @tun_dev_attach:
+ *
+ *	* @security pointer to the TUN device's security structure.
+ *
+ * int tun_dev_attach(struct sock \*sk, void \*security)
  *	This hook can be used by the module to update any security state
  *	associated with the TUN device's sock structure.
- *	@sk contains the existing sock structure.
- *	@security pointer to the TUN device's security structure.
- * @tun_dev_open:
+ *
+ *	* @sk contains the existing sock structure.
+ *	* @security pointer to the TUN device's security structure.
+ *
+ * int tun_dev_open(void \*security)
  *	This hook can be used by the module to update any security state
  *	associated with the TUN device's security structure.
- *	@security pointer to the TUN devices's security structure.
  *
- * Security hooks for SCTP
+ *	* @security pointer to the TUN devices's security structure.
  *
- * @sctp_assoc_request:
- *	Passes the @ep and @chunk->skb of the association INIT packet to
+ * **Security hooks for SCTP:**
+ *
+ * int sctp_assoc_request(struct sctp_endpoint \*ep, struct sk_buff \*skb)
+ *	Passes the @ep and @chunk->skb of the association %INIT packet to
  *	the security module.
- *	@ep pointer to sctp endpoint structure.
- *	@skb pointer to skbuff of association packet.
- *	Return 0 on success, error on failure.
- * @sctp_bind_connect:
+ *
+ *	* @ep pointer to sctp endpoint structure.
+ *	* @skb pointer to @skbuff of association packet.
+ *	* Return %0 on success, error on failure.
+ *
+ * int sctp_bind_connect(struct sock \*sk, int optname, struct sockaddr \*address, int addrlen)
  *	Validiate permissions required for each address associated with sock
  *	@sk. Depending on @optname, the addresses will be treated as either
  *	for a connect or bind service. The @addrlen is calculated on each
  *	ipv4 and ipv6 address using sizeof(struct sockaddr_in) or
  *	sizeof(struct sockaddr_in6).
- *	@sk pointer to sock structure.
- *	@optname name of the option to validate.
- *	@address list containing one or more ipv4/ipv6 addresses.
- *	@addrlen total length of address(s).
- *	Return 0 on success, error on failure.
- * @sctp_sk_clone:
+ *
+ *	* @sk pointer to sock structure.
+ *	* @optname name of the option to validate.
+ *	* @address list containing one or more ipv4/ipv6 addresses.
+ *	* @addrlen total length of address(s).
+ *	* Return %0 on success, error on failure.
+ *
+ * void sctp_sk_clone(struct sctp_endpoint \*ep, struct sock \*sk, struct sock \*newsk)
  *	Called whenever a new socket is created by accept(2) (i.e. a TCP
  *	style socket) or when a socket is 'peeled off' e.g userspace
  *	calls sctp_peeloff(3).
- *	@ep pointer to current sctp endpoint structure.
- *	@sk pointer to current sock structure.
- *	@sk pointer to new sock structure.
  *
- * Security hooks for Infiniband
+ *	* @ep pointer to current sctp endpoint structure.
+ *	* @sk pointer to current sock structure.
+ *	* @sk pointer to new sock structure.
  *
- * @ib_pkey_access:
+ * **Security hooks for Infiniband:**
+ *
+ * int ib_pkey_access(void \*sec, u64 subnet_prefix, u16 pkey)
  *	Check permission to access a pkey when modifing a QP.
- *	@subnet_prefix the subnet prefix of the port being used.
- *	@pkey the pkey to be accessed.
- *	@sec pointer to a security structure.
- * @ib_endport_manage_subnet:
+ *
+ *	* @subnet_prefix the subnet prefix of the port being used.
+ *	* @pkey the pkey to be accessed.
+ *	* @sec pointer to a security structure.
+ *
+ * int ib_endport_manage_subnet(void \*sec, const char \*dev_name, u8 port_num)
  *	Check permissions to send and receive SMPs on a end port.
- *	@dev_name the IB device name (i.e. mlx4_0).
- *	@port_num the port number.
- *	@sec pointer to a security structure.
- * @ib_alloc_security:
+ *
+ *	* @sec pointer to a security structure.
+ *	* @dev_name the IB device name (i.e. mlx4_0).
+ *	* @port_num the port number.
+ *
+ * int ib_alloc_security(void \*\*sec)
  *	Allocate a security structure for Infiniband objects.
- *	@sec pointer to a security structure pointer.
- *	Returns 0 on success, non-zero on failure
- * @ib_free_security:
+ *
+ *	* @sec pointer to a security structure pointer.
+ *	* Returns %0 on success, non-zero on failure
+ *
+ * void ib_free_security(void \*sec)
  *	Deallocate an Infiniband security structure.
- *	@sec contains the security structure to be freed.
  *
- * Security hooks for XFRM operations.
+ *	* @sec contains the security structure to be freed.
+ *
+ * **Security hooks for XFRM operations:**
  *
- * @xfrm_policy_alloc_security:
- *	@ctxp is a pointer to the xfrm_sec_ctx being added to Security Policy
- *	Database used by the XFRM system.
- *	@sec_ctx contains the security context information being provided by
- *	the user-level policy update program (e.g., setkey).
+ * int xfrm_policy_alloc_security(struct xfrm_sec_ctx \*\*ctxp, struct xfrm_user_sec_ctx \*sec_ctx, gfp_t gfp)
  *	Allocate a security structure to the xp->security field; the security
- *	field is initialized to NULL when the xfrm_policy is allocated.
- *	Return 0 if operation was successful (memory to allocate, legal context)
- *	@gfp is to specify the context for the allocation
- * @xfrm_policy_clone_security:
- *	@old_ctx contains an existing xfrm_sec_ctx.
- *	@new_ctxp contains a new xfrm_sec_ctx being cloned from old.
+ *	field is initialized to %NULL when the @xfrm_policy is allocated.
+ *
+ *	* @ctxp is a pointer to the xfrm_sec_ctx being added to Security Policy Database used by the XFRM system.
+ *	* @sec_ctx contains the security context information being provided by the user-level policy update program (e.g., setkey).
+ *	* @gfp is to specify the context for the allocation
+ *	* Return %0 if operation was successful (memory to allocate, legal context)
+ *
+ * int xfrm_policy_clone_security(struct xfrm_sec_ctx \*old_ctx, struct xfrm_sec_ctx \*\*new_ctx)
  *	Allocate a security structure in new_ctxp that contains the
- *	information from the old_ctx structure.
- *	Return 0 if operation was successful (memory to allocate).
- * @xfrm_policy_free_security:
- *	@ctx contains the xfrm_sec_ctx
- *	Deallocate xp->security.
- * @xfrm_policy_delete_security:
- *	@ctx contains the xfrm_sec_ctx.
- *	Authorize deletion of xp->security.
- * @xfrm_state_alloc:
- *	@x contains the xfrm_state being added to the Security Association
- *	Database by the XFRM system.
- *	@sec_ctx contains the security context information being provided by
- *	the user-level SA generation program (e.g., setkey or racoon).
- *	Allocate a security structure to the x->security field; the security
- *	field is initialized to NULL when the xfrm_state is allocated. Set the
- *	context to correspond to sec_ctx. Return 0 if operation was successful
- *	(memory to allocate, legal context).
- * @xfrm_state_alloc_acquire:
- *	@x contains the xfrm_state being added to the Security Association
- *	Database by the XFRM system.
- *	@polsec contains the policy's security context.
- *	@secid contains the secid from which to take the mls portion of the
- *	context.
- *	Allocate a security structure to the x->security field; the security
- *	field is initialized to NULL when the xfrm_state is allocated. Set the
- *	context to correspond to secid. Return 0 if operation was successful
- *	(memory to allocate, legal context).
- * @xfrm_state_free_security:
- *	@x contains the xfrm_state.
+ *	information from the @old_ctx structure.
+ *
+ *	* @old_ctx contains an existing @xfrm_sec_ctx.
+ *	* @new_ctxp contains a new @xfrm_sec_ctx being cloned from old.
+ *	* Return %0 if operation was successful (memory to allocate).
+ *
+ * void xfrm_policy_free_security(struct xfrm_sec_ctx \*ctx)
+ *	Deallocate @xp->security.
+ *
+ *	@ctx contains the @xfrm_sec_ctx
+ *
+ * int xfrm_policy_delete_security(struct xfrm_sec_ctx \*ctx)
+ *	Authorize deletion of @xp->security.
+ *
+ *	* @ctx contains the @xfrm_sec_ctx.
+ *
+ * int xfrm_state_alloc(struct xfrm_state \*x, struct xfrm_user_sec_ctx \*sec_ctx)
+ *	Allocate a security structure to the @x->security field; the security
+ *	field is initialized to %NULL when the @xfrm_state is allocated. Set the
+ *	context to correspond to @sec_ctx.
+ *
+ *	* @x contains the xfrm_state being added to the Security Association Database by the XFRM system.
+ *	* @sec_ctx contains the security context information being provided by the user-level SA generation program (e.g., setkey or racoon).
+ *	* Return %0 if operation was successful (memory to allocate, legal context).
+ *
+ * int xfrm_state_alloc_acquire(struct xfrm_state \*x, struct xfrm_sec_ctx \*polsec, u32 secid)
+ *	Allocate a security structure to the @x->security field; the security
+ *	field is initialized to %NULL when the @xfrm_state is allocated. Set the
+ *	context to correspond to @secid.
+ *
+ *	* @x contains the xfrm_state being added to the Security Association Database by the XFRM system.
+ *	* @polsec contains the policy's security context.
+ *	* @secid contains the @secid from which to take the mls portion of the context.
+ *	* Return %0 if operation was successful (memory to allocate, legal context).
+ *
+ * void xfrm_state_free_security(struct xfrm_state \*x)
  *	Deallocate x->security.
- * @xfrm_state_delete_security:
- *	@x contains the xfrm_state.
- *	Authorize deletion of x->security.
- * @xfrm_policy_lookup:
- *	@ctx contains the xfrm_sec_ctx for which the access control is being
- *	checked.
- *	@fl_secid contains the flow security label that is used to authorize
- *	access to the policy xp.
- *	@dir contains the direction of the flow (input or output).
- *	Check permission when a flow selects a xfrm_policy for processing
+ *
+ *	* @x contains the @xfrm_state.
+ *
+ * int xfrm_state_delete_security(struct xfrm_state \*x)
+ *	Authorize deletion of @x->security.
+ *
+ *	* @x contains the @xfrm_state.
+ *
+ * int xfrm_policy_lookup(struct xfrm_sec_ctx \*ctx, u32 fl_secid, u8 dir)
+ *	Check permission when a flow selects a @xfrm_policy for processing
  *	XFRMs on a packet.  The hook is called when selecting either a
  *	per-socket policy or a generic xfrm policy.
- *	Return 0 if permission is granted, -ESRCH otherwise, or -errno
- *	on other errors.
- * @xfrm_state_pol_flow_match:
- *	@x contains the state to match.
- *	@xp contains the policy to check for a match.
- *	@flic contains the flowi_common struct to check for a match.
- *	Return 1 if there is a match.
- * @xfrm_decode_session:
- *	@skb points to skb to decode.
- *	@secid points to the flow key secid to set.
- *	@ckall says if all xfrms used should be checked for same secid.
- *	Return 0 if ckall is zero or all xfrms used have the same secid.
- *
- * Security hooks affecting all Key Management operations
- *
- * @key_alloc:
+ *
+ *	* @ctx contains the @xfrm_sec_ctx for which the access control is being checked.
+ *	* @fl_secid contains the flow security label that is used to authorize access to the policy xp.
+ *	* @dir contains the direction of the flow (input or output).
+ *	* Return %0 if permission is granted, %-ESRCH otherwise, or %-errno on other errors.
+ *
+ * int xfrm_state_pol_flow_match(struct xfrm_state \*x, struct xfrm_policy \*xp, const struct flowi_common \*flic)
+ *	TODO Add function definition to correctly format kernel doc.
+ *
+ *	* @x contains the state to match.
+ *	* @xp contains the policy to check for a match.
+ *	* @flic contains the @flowi_common struct to check for a match.
+ *	* Return %1 if there is a match.
+ *
+ * int xfrm_decode_session(struct sk_buff \*skb, u32 \*secid, int ckall)
+ *	TODO Add function definition to correctly format kernel doc.
+ *
+ *	* @skb points to skb to decode.
+ *	* @secid points to the flow key @secid to set.
+ *	* @ckall says if all xfrms used should be checked for same @secid.
+ *	* Return %0 if @ckall is zero or all xfrms used have the same @secid.
+ *
+ * **Security hooks affecting all Key Management operations:**
+ *
+ * int key_alloc(struct key \*key, const struct cred \*cred, unsigned long flags)
  *	Permit allocation of a key and assign security data. Note that key does
  *	not have a serial number assigned at this point.
- *	@key points to the key.
- *	@flags is the allocation flags
- *	Return 0 if permission is granted, -ve error otherwise.
- * @key_free:
+ *
+ *	* @key points to the key.
+ *	* @flags is the allocation flags
+ *	* Return %0 if permission is granted, %-ve error otherwise.
+ *
+ * void key_free(struct key \*key)
  *	Notification of destruction; free security data.
- *	@key points to the key.
- *	No return value.
- * @key_permission:
+ *
+ *	* @key points to the key.
+ *	* No return value.
+ *
+ * int key_permission(key_ref_t key_ref, const struct cred \*cred, enum key_need_perm need_perm)
  *	See whether a specific operational right is granted to a process on a
  *	key.
- *	@key_ref refers to the key (key pointer + possession attribute bit).
- *	@cred points to the credentials to provide the context against which to
- *	evaluate the security data on the key.
- *	@perm describes the combination of permissions required of this key.
- *	Return 0 if permission is granted, -ve error otherwise.
- * @key_getsecurity:
+ *
+ *	* @key_ref refers to the key (key pointer + possession attribute bit).
+ *	* @cred points to the credentials to provide the context against which to evaluate the security data on the key.
+ *	* @perm describes the combination of permissions required of this key.
+ *	* Return %0 if permission is granted, %-ve error otherwise.
+ *
+ * int key_getsecurity(struct key \*key, char \*\*_buffer)
  *	Get a textual representation of the security context attached to a key
- *	for the purposes of honouring KEYCTL_GETSECURITY.  This function
- *	allocates the storage for the NUL-terminated string and the caller
+ *	for the purposes of honouring %KEYCTL_GETSECURITY.  This function
+ *	allocates the storage for the %NUL terminated string and the caller
  *	should free it.
- *	@key points to the key to be queried.
- *	@_buffer points to a pointer that should be set to point to the
- *	resulting string (if no label or an error occurs).
- *	Return the length of the string (including terminating NUL) or -ve if
- *	an error.
- *	May also return 0 (and a NULL buffer pointer) if there is no label.
  *
- * Security hooks affecting all System V IPC operations.
+ *	* @key points to the key to be queried.
+ *	* @_buffer points to a pointer that should be set to point to the resulting string (if no label or an error occurs).
+ *	* Return the length of the string (including terminating %NUL) or %-ve if an error.
+ *	* May also Return %0 (and a %NULL buffer pointer) if there is no label.
+ *
+ * **Security hooks affecting all System V IPC operations:**
  *
- * @ipc_permission:
+ * int ipc_permission(struct kern_ipc_perm \*ipcp, short flag)
  *	Check permissions for access to IPC
- *	@ipcp contains the kernel IPC permission structure
- *	@flag contains the desired (requested) permission set
- *	Return 0 if permission is granted.
- * @ipc_getsecid:
+ *
+ *	* @ipcp contains the kernel IPC permission structure
+ *	* @flag contains the desired (requested) permission set
+ *	* Return %0 if permission is granted.
+ *
+ * void ipc_getsecid(struct kern_ipc_perm \*ipcp, u32 \*secid)
  *	Get the secid associated with the ipc object.
- *	@ipcp contains the kernel IPC permission structure.
- *	@secid contains a pointer to the location where result will be saved.
- *	In case of failure, @secid will be set to zero.
  *
- * Security hooks for individual messages held in System V IPC message queues
+ *	* @ipcp contains the kernel IPC permission structure.
+ *	* @secid contains a pointer to the location where result will be saved.
+ *	* In case of failure, @secid will be set to zero.
+ *
+ * **Security hooks for individual messages held in System V IPC message queues:**
  *
- * @msg_msg_alloc_security:
- *	Allocate and attach a security structure to the msg->security field.
- *	The security field is initialized to NULL when the structure is first
+ * int msg_msg_alloc_security(struct msg_msg \*msg)
+ *	Allocate and attach a security structure to the @msg->security field.
+ *	The security field is initialized to %NULL when the structure is first
  *	created.
- *	@msg contains the message structure to be modified.
- *	Return 0 if operation was successful and permission is granted.
- * @msg_msg_free_security:
+ *
+ *	* @msg contains the message structure to be modified.
+ *	* Return %0 if operation was successful and permission is granted.
+ *
+ * void msg_msg_free_security(struct msg_msg \*msg)
  *	Deallocate the security structure for this message.
- *	@msg contains the message structure to be modified.
  *
- * Security hooks for System V IPC Message Queues
+ *	* @msg contains the message structure to be modified.
+ *
+ * **Security hooks for System V IPC Message Queues:**
  *
- * @msg_queue_alloc_security:
+ * int msg_queue_alloc_security(struct kern_ipc_perm \*perm)
  *	Allocate and attach a security structure to the
  *	@perm->security field. The security field is initialized to
- *	NULL when the structure is first created.
- *	@perm contains the IPC permissions of the message queue.
- *	Return 0 if operation was successful and permission is granted.
- * @msg_queue_free_security:
+ *	%NULL when the structure is first created.
+ *
+ *	* @perm contains the IPC permissions of the message queue.
+ *	* Return %0 if operation was successful and permission is granted.
+ *
+ * void msg_queue_free_security(struct kern_ipc_perm \*perm)
  *	Deallocate security field @perm->security for the message queue.
- *	@perm contains the IPC permissions of the message queue.
- * @msg_queue_associate:
+ *
+ *	* @perm contains the IPC permissions of the message queue.
+ *
+ * int msg_queue_associate(struct kern_ipc_perm \*perm, int msqflg)
  *	Check permission when a message queue is requested through the
  *	msgget system call. This hook is only called when returning the
  *	message queue identifier for an existing message queue, not when a
  *	new message queue is created.
- *	@perm contains the IPC permissions of the message queue.
- *	@msqflg contains the operation control flags.
- *	Return 0 if permission is granted.
- * @msg_queue_msgctl:
+ *
+ *	* @perm contains the IPC permissions of the message queue.
+ *	* @msqflg contains the operation control flags.
+ *	* Return %0 if permission is granted.
+ *
+ * int msg_queue_msgctl(struct kern_ipc_perm \*perm, int cmd)
  *	Check permission when a message control operation specified by @cmd
  *	is to be performed on the message queue with permissions @perm.
- *	The @perm may be NULL, e.g. for IPC_INFO or MSG_INFO.
- *	@perm contains the IPC permissions of the msg queue. May be NULL.
- *	@cmd contains the operation to be performed.
- *	Return 0 if permission is granted.
- * @msg_queue_msgsnd:
+ *	The @perm may be %NULL, e.g. for %IPC_INFO or %MSG_INFO.
+ *
+ *	* @perm contains the IPC permissions of the msg queue. May be %NULL.
+ *	* @cmd contains the operation to be performed.
+ *	* Return %0 if permission is granted.
+ *
+ * int msg_queue_msgsnd(struct kern_ipc_perm \*perm, struct msg_msg \*msg, int msqflg)
  *	Check permission before a message, @msg, is enqueued on the message
  *	queue with permissions @perm.
- *	@perm contains the IPC permissions of the message queue.
- *	@msg contains the message to be enqueued.
- *	@msqflg contains operational flags.
- *	Return 0 if permission is granted.
- * @msg_queue_msgrcv:
+ *
+ *	* @perm contains the IPC permissions of the message queue.
+ *	* @msg contains the message to be enqueued.
+ *	* @msqflg contains operational flags.
+ *	* Return %0 if permission is granted.
+ *
+ * int msg_queue_msgrcv(struct kern_ipc_perm \*perm, struct msg_msg \*msg, struct task_struct \*target, long type, int mode)
  *	Check permission before a message, @msg, is removed from the message
  *	queue. The @target task structure contains a pointer to the
  *	process that will be receiving the message (not equal to the current
  *	process when inline receives are being performed).
- *	@perm contains the IPC permissions of the message queue.
- *	@msg contains the message destination.
- *	@target contains the task structure for recipient process.
- *	@type contains the type of message requested.
- *	@mode contains the operational flags.
- *	Return 0 if permission is granted.
  *
- * Security hooks for System V Shared Memory Segments
+ *	* @perm contains the IPC permissions of the message queue.
+ *	* @msg contains the message destination.
+ *	* @target contains the task structure for recipient process.
+ *	* @type contains the type of message requested.
+ *	* @mode contains the operational flags.
+ *	* Return %0 if permission is granted.
+ *
+ * **Security hooks for System V Shared Memory Segments:**
  *
- * @shm_alloc_security:
+ * int shm_alloc_security(struct kern_ipc_perm \*perm)
  *	Allocate and attach a security structure to the @perm->security
- *	field. The security field is initialized to NULL when the structure is
+ *	field. The security field is initialized to %NULL when the structure is
  *	first created.
- *	@perm contains the IPC permissions of the shared memory structure.
- *	Return 0 if operation was successful and permission is granted.
- * @shm_free_security:
+ *
+ *	* @perm contains the IPC permissions of the shared memory structure.
+ *	* Return %0 if operation was successful and permission is granted.
+ *
+ * void shm_free_security(struct kern_ipc_perm \*perm)
  *	Deallocate the security structure @perm->security for the memory segment.
- *	@perm contains the IPC permissions of the shared memory structure.
- * @shm_associate:
+ *
+ *	* @perm contains the IPC permissions of the shared memory structure.
+ *
+ * int shm_associate(struct kern_ipc_perm \*perm, int shmflg)
  *	Check permission when a shared memory region is requested through the
- *	shmget system call. This hook is only called when returning the shared
+ *	@shmget() system call. This hook is only called when returning the shared
  *	memory region identifier for an existing region, not when a new shared
  *	memory region is created.
- *	@perm contains the IPC permissions of the shared memory structure.
- *	@shmflg contains the operation control flags.
- *	Return 0 if permission is granted.
- * @shm_shmctl:
+ *
+ *	* @perm contains the IPC permissions of the shared memory structure.
+ *	* @shmflg contains the operation control flags.
+ *	* Return %0 if permission is granted.
+ *
+ * int shm_shmctl(struct kern_ipc_perm \*perm, int cmd)
  *	Check permission when a shared memory control operation specified by
  *	@cmd is to be performed on the shared memory region with permissions @perm.
- *	The @perm may be NULL, e.g. for IPC_INFO or SHM_INFO.
- *	@perm contains the IPC permissions of the shared memory structure.
- *	@cmd contains the operation to be performed.
- *	Return 0 if permission is granted.
- * @shm_shmat:
+ *	The @perm may be %NULL, e.g. for %IPC_INFO or %SHM_INFO.
+ *
+ *	* @perm contains the IPC permissions of the shared memory structure.
+ *	* @cmd contains the operation to be performed.
+ *	* Return %0 if permission is granted.
+ *
+ * int shm_shmat(struct kern_ipc_perm \*perm, char __user \*shmaddr, int shmflg)
  *	Check permissions prior to allowing the shmat system call to attach the
  *	shared memory segment with permissions @perm to the data segment of the
  *	calling process. The attaching address is specified by @shmaddr.
- *	@perm contains the IPC permissions of the shared memory structure.
- *	@shmaddr contains the address to attach memory region to.
- *	@shmflg contains the operational flags.
- *	Return 0 if permission is granted.
  *
- * Security hooks for System V Semaphores
+ *	* @perm contains the IPC permissions of the shared memory structure.
+ *	* @shmaddr contains the address to attach memory region to.
+ *	* @shmflg contains the operational flags.
+ *	* Return %0 if permission is granted.
+ *
+ * **Security hooks for System V Semaphores:**
  *
- * @sem_alloc_security:
+ * int sem_alloc_security(struct kern_ipc_perm \*perm)
  *	Allocate and attach a security structure to the @perm->security
- *	field. The security field is initialized to NULL when the structure is
+ *	field. The security field is initialized to %NULL when the structure is
  *	first created.
- *	@perm contains the IPC permissions of the semaphore.
- *	Return 0 if operation was successful and permission is granted.
- * @sem_free_security:
+ *
+ *	* @perm contains the IPC permissions of the semaphore.
+ *	* Return %0 if operation was successful and permission is granted.
+ *
+ * void sem_free_security(struct kern_ipc_perm \*perm)
  *	Deallocate security structure @perm->security for the semaphore.
- *	@perm contains the IPC permissions of the semaphore.
- * @sem_associate:
- *	Check permission when a semaphore is requested through the semget
+ *
+ *	* @perm contains the IPC permissions of the semaphore.
+ *
+ * int sem_associate(struct kern_ipc_perm \*perm, int semflg)
+ *	Check permission when a semaphore is requested through the @semget()
  *	system call. This hook is only called when returning the semaphore
  *	identifier for an existing semaphore, not when a new one must be
  *	created.
- *	@perm contains the IPC permissions of the semaphore.
- *	@semflg contains the operation control flags.
- *	Return 0 if permission is granted.
- * @sem_semctl:
+ *
+ *	* @perm contains the IPC permissions of the semaphore.
+ *	* @semflg contains the operation control flags.
+ *	* Return %0 if permission is granted.
+ *
+ * int sem_semctl(struct kern_ipc_perm \*perm, int cmd)
  *	Check permission when a semaphore operation specified by @cmd is to be
- *	performed on the semaphore. The @perm may be NULL, e.g. for
- *	IPC_INFO or SEM_INFO.
- *	@perm contains the IPC permissions of the semaphore. May be NULL.
- *	@cmd contains the operation to be performed.
- *	Return 0 if permission is granted.
- * @sem_semop:
+ *	performed on the semaphore. The @perm may be %NULL, e.g. for
+ *	%IPC_INFO or %SEM_INFO.
+ *
+ *	* @perm contains the IPC permissions of the semaphore. May be %NULL.
+ *	* @cmd contains the operation to be performed.
+ *	* Return %0 if permission is granted.
+ *
+ * int sem_semop(struct kern_ipc_perm \*perm, struct sembuf \*sops, unsigned nsops, int alter)
  *	Check permissions before performing operations on members of the
  *	semaphore set. If the @alter flag is nonzero, the semaphore set
  *	may be modified.
- *	@perm contains the IPC permissions of the semaphore.
- *	@sops contains the operations to perform.
- *	@nsops contains the number of operations to perform.
- *	@alter contains the flag indicating whether changes are to be made.
- *	Return 0 if permission is granted.
  *
- * @binder_set_context_mgr:
+ *	* @perm contains the IPC permissions of the semaphore.
+ *	* @sops contains the operations to perform.
+ *	* @nsops contains the number of operations to perform.
+ *	* @alter contains the flag indicating whether changes are to be made.
+ *	* Return %0 if permission is granted.
+ *
+ * **Security hooks for Binder device:**
+ *
+ * int binder_set_context_mgr(struct task_struct \*mgr)
  *	Check whether @mgr is allowed to be the binder context manager.
- *	@mgr contains the task_struct for the task being registered.
- *	Return 0 if permission is granted.
- * @binder_transaction:
+ *
+ *	* @mgr contains the @task_struct for the task being registered.
+ *	* Return %0 if permission is granted.
+ *
+ * int binder_transaction(struct task_struct \*from, struct task_struct \*to)
  *	Check whether @from is allowed to invoke a binder transaction call
  *	to @to.
- *	@from contains the task_struct for the sending task.
- *	@to contains the task_struct for the receiving task.
- * @binder_transfer_binder:
+ *
+ *	* @from contains the @task_struct for the sending task.
+ *	* @to contains the @task_struct for the receiving task.
+ *
+ * int binder_transfer_binder(struct task_struct \*from, struct task_struct \*to)
  *	Check whether @from is allowed to transfer a binder reference to @to.
- *	@from contains the task_struct for the sending task.
- *	@to contains the task_struct for the receiving task.
- * @binder_transfer_file:
+ *
+ *	* @from contains the @task_struct for the sending task.
+ *	* @to contains the @task_struct for the receiving task.
+ *
+ * int binder_transfer_file(struct task_struct \*from, struct task_struct \*to, struct file \*file)
  *	Check whether @from is allowed to transfer @file to @to.
- *	@from contains the task_struct for the sending task.
- *	@file contains the struct file being transferred.
- *	@to contains the task_struct for the receiving task.
  *
- * @ptrace_access_check:
+ *	* @from contains the @task_struct for the sending task.
+ *	* @file contains the struct file being transferred.
+ *	* @to contains the @task_struct for the receiving task.
+ *
+ * **Security hooks for ptrace:**
+ *
+ * int ptrace_access_check(struct task_struct \*child, unsigned int mode)
  *	Check permission before allowing the current process to trace the
  *	@child process.
  *	Security modules may also want to perform a process tracing check
- *	during an execve in the set_security or apply_creds hooks of
- *	tracing check during an execve in the bprm_set_creds hook of
- *	binprm_security_ops if the process is being traced and its security
- *	attributes would be changed by the execve.
- *	@child contains the task_struct structure for the target process.
- *	@mode contains the PTRACE_MODE flags indicating the form of access.
- *	Return 0 if permission is granted.
- * @ptrace_traceme:
+ *	during an @execve in the set_security or @apply_creds() hooks of
+ *	tracing check during an @execve in the @bprm_set_creds() hook of
+ *	@binprm_security_ops() if the process is being traced and its security
+ *	attributes would be changed by the @execve.
+ *
+ *	* @child contains the @task_struct structure for the target process.
+ *	* @mode contains the %PTRACE_MODE flags indicating the form of access.
+ *	* Return %0 if permission is granted.
+ *
+ * int ptrace_traceme(struct task_struct \*parent)
  *	Check that the @parent process has sufficient permission to trace the
  *	current process before allowing the current process to present itself
  *	to the @parent process for tracing.
- *	@parent contains the task_struct structure for debugger process.
- *	Return 0 if permission is granted.
- * @capget:
+ *
+ *	* @parent contains the @task_struct structure for debugger process.
+ *	* Return %0 if permission is granted.
+ *
+ * int capget(struct task_struct \*target, kernel_cap_t \*effective, kernel_cap_t \*inheritable, kernel_cap_t \*permitted)
  *	Get the @effective, @inheritable, and @permitted capability sets for
  *	the @target process.  The hook may also perform permission checking to
  *	determine if the current process is allowed to see the capability sets
  *	of the @target process.
- *	@target contains the task_struct structure for target process.
- *	@effective contains the effective capability set.
- *	@inheritable contains the inheritable capability set.
- *	@permitted contains the permitted capability set.
- *	Return 0 if the capability sets were successfully obtained.
- * @capset:
+ *
+ *	* @target contains the @task_struct structure for target process.
+ *	* @effective contains the effective capability set.
+ *	* @inheritable contains the inheritable capability set.
+ *	* @permitted contains the permitted capability set.
+ *	* Return %0 if the capability sets were successfully obtained.
+ *
+ * int capset(struct cred \*new, const struct cred \*old, const kernel_cap_t \*effective, const kernel_cap_t \*inheritable, const kernel_cap_t \*permitted)
  *	Set the @effective, @inheritable, and @permitted capability sets for
  *	the current process.
- *	@new contains the new credentials structure for target process.
- *	@old contains the current credentials structure for target process.
- *	@effective contains the effective capability set.
- *	@inheritable contains the inheritable capability set.
- *	@permitted contains the permitted capability set.
- *	Return 0 and update @new if permission is granted.
- * @capable:
+ *
+ *	* @new contains the new credentials structure for target process.
+ *	* @old contains the current credentials structure for target process.
+ *	* @effective contains the effective capability set.
+ *	* @inheritable contains the inheritable capability set.
+ *	* @permitted contains the permitted capability set.
+ *	* Return %0 and update @new if permission is granted.
+ *
+ * int capable(const struct cred \*cred, struct user_namespace \*ns, int cap, unsigned int opts)
  *	Check whether the @tsk process has the @cap capability in the indicated
  *	credentials.
- *	@cred contains the credentials to use.
- *	@ns contains the user namespace we want the capability in
- *	@cap contains the capability <include/linux/capability.h>.
- *	@opts contains options for the capable check <include/linux/security.h>
- *	Return 0 if the capability is granted for @tsk.
- * @quotactl:
- * 	Check whether the quotactl syscall is allowed for this @sb.
- * @quota_on:
- * 	Check whether QUOTAON is allowed for this @dentry.
- * @syslog:
+ *
+ *	* @cred contains the credentials to use.
+ *	* @ns contains the user namespace we want the capability in
+ *	* @cap contains the capability <include/linux/capability.h>.
+ *	* @opts contains options for the capable check <include/linux/security.h>
+ *	* Return %0 if the capability is granted for @tsk.
+ *
+ * int quotactl(int cmds, int type, int id, struct super_block \*sb)
+ * 	Check whether the @quotactl syscall is allowed for this @sb.
+ *
+ * int quota_on(struct dentry \*dentry)
+ *	Check whether %QUOTAON is allowed for this @dentry.
+ *
+ * int syslog(int type)
  *	Check permission before accessing the kernel message ring or changing
  *	logging to the console.
  *	See the syslog(2) manual page for an explanation of the @type values.
- *	@type contains the SYSLOG_ACTION_* constant from <include/linux/syslog.h>
- *	Return 0 if permission is granted.
- * @settime:
+ *
+ *	* @type contains the %SYSLOG_ACTION_\* constant from <include/linux/syslog.h>
+ *	* Return %0 if permission is granted.
+ *
+ * int settime(const struct timespec64 \*ts, const struct timezone \*tz)
  *	Check permission to change the system time.
  *	struct timespec64 is defined in <include/linux/time64.h> and timezone
  *	is defined in <include/linux/time.h>
- *	@ts contains new time
- *	@tz contains new timezone
- *	Return 0 if permission is granted.
- * @vm_enough_memory:
+ *
+ *	* @ts contains new time
+ *	* @tz contains new timezone
+ *	* Return %0 if permission is granted.
+ *
+ * int vm_enough_memory(struct mm_struct \*mm, long pages)
  *	Check permissions for allocating a new virtual mapping.
- *	@mm contains the mm struct it is being added to.
- *	@pages contains the number of pages.
- *	Return 0 if permission is granted.
  *
- * @ismaclabel:
+ *	* @mm contains the mm struct it is being added to.
+ *	* @pages contains the number of pages.
+ *	* Return %0 if permission is granted.
+ *
+ * int ismaclabel(const char \*name)
  *	Check if the extended attribute specified by @name
- *	represents a MAC label. Returns 1 if name is a MAC
- *	attribute otherwise returns 0.
- *	@name full extended attribute name to check against
- *	LSM as a MAC label.
- *
- * @secid_to_secctx:
- *	Convert secid to security context.  If secdata is NULL the length of
- *	the result will be returned in seclen, but no secdata will be returned.
+ *	represents a MAC label. Returns %1 if name is a MAC
+ *	attribute otherwise returns %0.
+ *
+ *	* @name full extended attribute name to check against LSM as a MAC label.
+ *
+ * **Security hooks for managing security blobs:**
+ *
+ * int secid_to_secctx(u32 secid, char \*\*secdata, u32 \*seclen)
+ *	Convert @secid to security context.  If @secdata is %NULL the length of
+ *	the result will be returned in @seclen, but no @secdata will be returned.
  *	This does mean that the length could change between calls to check the
  *	length and the next call which actually allocates and returns the
- *	secdata.
- *	@secid contains the security ID.
- *	@secdata contains the pointer that stores the converted security
- *	context.
- *	@seclen pointer which contains the length of the data
- * @secctx_to_secid:
- *	Convert security context to secid.
- *	@secid contains the pointer to the generated security ID.
- *	@secdata contains the security context.
- *
- * @release_secctx:
+ *	@secdata.
+ *
+ *	* @secid contains the security ID.
+ *	* @secdata contains the pointer that stores the converted security context.
+ *	* @seclen pointer which contains the length of the data
+ *
+ * int secctx_to_secid(const char \*secdata, u32 seclen, u32 \*secid)
+ *	Convert security context to @secid.
+ *
+ *	* @secid contains the pointer to the generated security ID.
+ *	* @secdata contains the security context.
+ *
+ * void release_secctx(char \*secdata, u32 seclen)
  *	Release the security context.
- *	@secdata contains the security context.
- *	@seclen contains the length of the security context.
  *
- * Security hooks for Audit
+ *	* @secdata contains the security context.
+ *	* @seclen contains the length of the security context.
  *
- * @audit_rule_init:
+ * **Security hooks for Audit:**
+ *
+ * int audit_rule_init(u32 field, u32 op, char \*rulestr, void \*\*lsmrule)
  *	Allocate and initialize an LSM audit rule structure.
- *	@field contains the required Audit action.
- *	Fields flags are defined in <include/linux/audit.h>
- *	@op contains the operator the rule uses.
- *	@rulestr contains the context where the rule will be applied to.
- *	@lsmrule contains a pointer to receive the result.
- *	Return 0 if @lsmrule has been successfully set,
- *	-EINVAL in case of an invalid rule.
- *
- * @audit_rule_known:
+ *
+ *	* @field contains the required Audit action. Fields flags are defined in <include/linux/audit.h>
+ *	* @op contains the operator the rule uses.
+ *	* @rulestr contains the context where the rule will be applied to.
+ *	* @lsmrule contains a pointer to receive the result.
+ *	* Return %0 if @lsmrule has been successfully set,
+ *	* %-EINVAL in case of an invalid rule.
+ *
+ * int audit_rule_known(struct audit_krule \*krule)
  *	Specifies whether given @krule contains any fields related to
  *	current LSM.
- *	@krule contains the audit rule of interest.
- *	Return 1 in case of relation found, 0 otherwise.
  *
- * @audit_rule_match:
+ *	* @krule contains the audit rule of interest.
+ *	* Return %1 in case of relation found, 0 otherwise.
+ *
+ * int audit_rule_match(u32 secid, u32 field, u32 op, void \*lsmrule)
  *	Determine if given @secid matches a rule previously approved
  *	by @audit_rule_known.
- *	@secid contains the security id in question.
- *	@field contains the field which relates to current LSM.
- *	@op contains the operator that will be used for matching.
- *	@lrule points to the audit rule that will be checked against.
- *	Return 1 if secid matches the rule, 0 if it does not, -ERRNO on failure.
  *
- * @audit_rule_free:
+ *	* @secid contains the security id in question.
+ *	* @field contains the field which relates to current LSM.
+ *	* @op contains the operator that will be used for matching.
+ *	* @lsmrule points to the audit rule that will be checked against.
+ *	* Return %1 if @secid matches the rule, %0 if it does not, %-ERRNO on failure.
+ *
+ * void audit_rule_free(void \*lsmrule)
  *	Deallocate the LSM audit rule structure previously allocated by
- *	audit_rule_init.
- *	@lsmrule contains the allocated rule
+ *	@audit_rule_init().
+ *
+ *	* @lsmrule contains the allocated rule
+ *
+ * **Security hooks for more inode services:**
  *
- * @inode_invalidate_secctx:
+ * void inode_invalidate_secctx(struct inode \*inode)
  *	Notify the security module that it must revalidate the security context
  *	of an inode.
  *
- * @inode_notifysecctx:
+ * int inode_notifysecctx(struct inode \*inode, void \*ctx, u32 ctxlen)
  *	Notify the security module of what the security context of an inode
  *	should be.  Initializes the incore security context managed by the
  *	security module for this inode.  Example usage:  NFS client invokes
  *	this hook to initialize the security context in its incore inode to the
  *	value provided by the server for the file when the server returned the
  *	file's attributes to the client.
- *	Must be called with inode->i_mutex locked.
- *	@inode we wish to set the security context of.
- *	@ctx contains the string which we wish to set in the inode.
- *	@ctxlen contains the length of @ctx.
+ *	Must be called with @inode->i_mutex locked.
  *
- * @inode_setsecctx:
+ *	* @inode we wish to set the security context of.
+ *	* @ctx contains the string which we wish to set in the inode.
+ *	* @ctxlen contains the length of @ctx.
+ *
+ * int inode_setsecctx(struct dentry \*dentry, void \*ctx, u32 ctxlen)
  *	Change the security context of an inode.  Updates the
  *	incore security context managed by the security module and invokes the
- *	fs code as needed (via __vfs_setxattr_noperm) to update any backing
- *	xattrs that represent the context.  Example usage:  NFS server invokes
+ *	fs code as needed (via @__vfs_setxattr_noperm()) to update any backing
+ *	@xattrs that represent the context.  Example usage:  NFS server invokes
  *	this hook to change the security context in its incore inode and on the
- *	backing filesystem to a value provided by the client on a SETATTR
+ *	backing filesystem to a value provided by the client on a %SETATTR
  *	operation.
- *	Must be called with inode->i_mutex locked.
- *	@dentry contains the inode we wish to set the security context of.
- *	@ctx contains the string which we wish to set in the inode.
- *	@ctxlen contains the length of @ctx.
+ *	Must be called with @inode->i_mutex locked.
+ *
+ *	* @dentry contains the inode we wish to set the security context of.
+ *	* @ctx contains the string which we wish to set in the inode.
+ *	* @ctxlen contains the length of @ctx.
  *
- * @inode_getsecctx:
- *	On success, returns 0 and fills out @ctx and @ctxlen with the security
+ * int inode_getsecctx(struct inode \*inode, void \*\*ctx, u32 \*ctxlen)
+ *	On success, returns %0 and fills out @ctx and @ctxlen with the security
  *	context for the given @inode.
- *	@inode we wish to get the security context of.
- *	@ctx is a pointer in which to place the allocated security context.
- *	@ctxlen points to the place to put the length of @ctx.
  *
- * Security hooks for the general notification queue:
+ *	* @inode we wish to get the security context of.
+ *	* @ctx is a pointer in which to place the allocated security context.
+ *	* @ctxlen points to the place to put the length of @ctx.
+ *
+ * **Security hooks for the general notification queue:**
  *
- * @post_notification:
+ * int post_notification(const struct cred \*w_cred, const struct cred \*cred, struct watch_notification \*n)
  *	Check to see if a watch notification can be posted to a particular
  *	queue.
- *	@w_cred: The credentials of the whoever set the watch.
- *	@cred: The event-triggerer's credentials
- *	@n: The notification being posted
  *
- * @watch_key:
+ *	* @w_cred The credentials of the whoever set the watch.
+ *	* @cred The event-triggerer's credentials
+ *	* @n The notification being posted
+ *
+ * int watch_key(struct key \*key)
  *	Check to see if a process is allowed to watch for event notifications
  *	from a key or keyring.
- *	@key: The key to watch.
  *
- * Security hooks for using the eBPF maps and programs functionalities through
- * eBPF syscalls.
+ *	* @key The key to watch.
+ *
+ * **Security hooks for using the eBPF maps and programs functionalities**
+ * **through eBPF syscalls:**
  *
- * @bpf:
- *	Do a initial check for all bpf syscalls after the attribute is copied
+ * int bpf(int cmd, union bpf_attr \*attr, unsigned int size)
+ *	Do a initial check for all @bpf syscalls after the attribute is copied
  *	into the kernel. The actual security module can implement their own
  *	rules to check the specific cmd they need.
  *
- * @bpf_map:
+ * int bpf_map(struct bpf_map \*map, fmode_t fmode)
  *	Do a check when the kernel generate and return a file descriptor for
  *	eBPF maps.
  *
- *	@map: bpf map that we want to access
- *	@mask: the access flags
+ *	* @map bpf map that we want to access
+ *	* @mask the access flags
  *
- * @bpf_prog:
+ * int bpf_prog(struct bpf_prog \*prog)
  *	Do a check when the kernel generate and return a file descriptor for
  *	eBPF programs.
  *
- *	@prog: bpf prog that userspace want to use.
+ *	* @prog bpf prog that userspace want to use.
  *
- * @bpf_map_alloc_security:
+ * int bpf_map_alloc_security(struct bpf_map \*map)
  *	Initialize the security field inside bpf map.
  *
- * @bpf_map_free_security:
+ * void bpf_map_free_security((struct bpf_map \*map)
  *	Clean up the security information stored inside bpf map.
  *
- * @bpf_prog_alloc_security:
+ * int bpf_prog_alloc_security(struct bpf_prog_aux \*aux)
  *	Initialize the security field inside bpf program.
  *
- * @bpf_prog_free_security:
+ * void bpf_prog_free_security(struct bpf_prog_aux \*aux)
  *	Clean up the security information stored inside bpf prog.
  *
- * @locked_down:
+ * **Security hooks for lockdown:**
+ *
+ * int locked_down(enum lockdown_reason what)
  *     Determine whether a kernel feature that potentially enables arbitrary
  *     code execution in kernel space should be permitted.
  *
- *     @what: kernel feature being accessed
+ *	* @what kernel feature being accessed
+ *
+ * **Security hooks for perf events:**
+ *
+ * int perf_event_open(struct perf_event_attr \*attr, int type)
+ *	Check whether the @type of @perf_event_open() @syscall() is allowed.
+ *
+ * int perf_event_alloc(struct perf_event \*event)
+ *	Allocate and save @perf_event security info.
+ *
+ * void perf_event_free(struct perf_event \*event)
+ *	Release (free) @perf_event security info.
  *
- * Security hooks for perf events
+ * int perf_event_read(struct perf_event \*event)
+ *	Read @perf_event security info if allowed.
  *
- * @perf_event_open:
- * 	Check whether the @type of perf_event_open syscall is allowed.
- * @perf_event_alloc:
- * 	Allocate and save perf_event security info.
- * @perf_event_free:
- * 	Release (free) perf_event security info.
- * @perf_event_read:
- * 	Read perf_event security info if allowed.
- * @perf_event_write:
- * 	Write perf_event security info if allowed.
+ * int perf_event_write(struct perf_event \event)
+ *	Write @perf_event security info if allowed.
  */
 union security_list_options {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
-- 
2.30.2

