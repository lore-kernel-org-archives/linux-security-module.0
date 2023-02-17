Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F5BC636D4
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 03:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjBQD1D (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjBQD0z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 22:26:55 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64434BEAA
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:43 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id c2so4294551qtw.5
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYdBEU3BL+8WTRHItAqAEX2AdNcr6nZU4mtlQLPhs6c=;
        b=AG1Ngp5ThPTxzvEmOGswbXuac7b5sYH2dRArTEcVncItc0BTJzQm/JRZJkHirRt8jK
         a8A8hVmKE8BMZEZDSjTVQXBmBXaZH5Ztk8K8ExMdit0XTDYtzYKCfBtMox6fNNIwNOxs
         vtEyXoc/0VIC+mjtRQ2GZxMJnxH/KA0qAF+BlHKOeGYtqjlJ2CSaIDCJXFatXAk7ql+Q
         vxEac1CgZIcI4ktJHKXVqbhzKwNDW0rqmDeHrp3Dv1tQKcOQv/7DMi1KWUOwnoWWwUS8
         rBlBoYJ9/3Zk73MVaxbnnK41A/vvLpwh/v4HZHRW21FZrB+IRqvQg2ZqbZvGZU5GBEnQ
         90bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYdBEU3BL+8WTRHItAqAEX2AdNcr6nZU4mtlQLPhs6c=;
        b=Nff9SgSoksZPTr04euz8qdF5H5mtg86xFuMTpPZWlqr3OpTlpPmg6gkqp1mTbqIZA2
         JjBsZ18Z2HMkYuO4g0gA2PD1mu6ixcpeitQTUZsu9R1zd1YKJsARhVxrATmne2Hn6KWo
         QUHWMv7VBO7O0XQqXrzuGjinxAyeBHSPTSomrHovrX2UKEYMQDVLcrTPWlxxNo9/G06L
         z+yYYh5ixBNyQFQCiPPqMcKfU1F/mtfNdjzQYG1fuJu8+o2v3+TQUKF0sr1eF5ZZEnYK
         LdwzFg26GOmMJ7AcPVu36LIF3toMYsNjVQNFXI1ht/eSRTJDmdBswPT+2KLchigCkXOL
         jPeg==
X-Gm-Message-State: AO0yUKWBvihczycXkU7endW0njffc2KvhkZttrdpgdqgE3uQjzQE8SbH
        Qz21tnTpwRe9nAGnkof/ji9QtShqwepkqfk=
X-Google-Smtp-Source: AK7set/4i5zK2+HncCJtw/tbdxXiQchV9g9Xoo66yMt6wZ423xbSh6Zv25nHnz+sDSL46M2nhhnHGQ==
X-Received: by 2002:a05:622a:1392:b0:3b6:323d:bcac with SMTP id o18-20020a05622a139200b003b6323dbcacmr13880240qtk.32.1676604402363;
        Thu, 16 Feb 2023 19:26:42 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id n6-20020ac86746000000b003b34650039bsm2421817qtp.76.2023.02.16.19.26.41
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 19:26:41 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 10/22] lsm: move the socket hook comments to security/security.c
Date:   Thu, 16 Feb 2023 22:26:13 -0500
Message-Id: <20230217032625.678457-11-paul@paul-moore.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230217032625.678457-1-paul@paul-moore.com>
References: <20230217032625.678457-1-paul@paul-moore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch relocates the LSM hook function comments to the function
definitions, in keeping with the current kernel conventions.  This
should make the hook descriptions more easily discoverable and easier
to maintain.

While formatting changes have been done to better fit the kernel-doc
style, content changes have been kept to a minimum and limited to
text which was obviously incorrect and/or outdated.  It is expected
the future patches will improve the quality of the function header
comments.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hooks.h | 191 ----------------------
 security/security.c       | 322 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 322 insertions(+), 191 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 1fc1e2aa7d01..531d141083ed 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -32,197 +32,6 @@
 /**
  * union security_list_options - Linux Security Module hook function list
  *
- * Security hooks for socket operations.
- *
- * @socket_create:
- *	Check permissions prior to creating a new socket.
- *	@family contains the requested protocol family.
- *	@type contains the requested communications type.
- *	@protocol contains the requested protocol.
- *	@kern set to 1 if a kernel socket.
- *	Return 0 if permission is granted.
- * @socket_post_create:
- *	This hook allows a module to update or allocate a per-socket security
- *	structure. Note that the security field was not added directly to the
- *	socket structure, but rather, the socket security information is stored
- *	in the associated inode.  Typically, the inode alloc_security hook will
- *	allocate and attach security information to
- *	SOCK_INODE(sock)->i_security.  This hook may be used to update the
- *	SOCK_INODE(sock)->i_security field with additional information that
- *	wasn't available when the inode was allocated.
- *	@sock contains the newly created socket structure.
- *	@family contains the requested protocol family.
- *	@type contains the requested communications type.
- *	@protocol contains the requested protocol.
- *	@kern set to 1 if a kernel socket.
- *	Return 0 if permission is granted.
- * @socket_socketpair:
- *	Check permissions before creating a fresh pair of sockets.
- *	@socka contains the first socket structure.
- *	@sockb contains the second socket structure.
- *	Return 0 if permission is granted and the connection was established.
- * @socket_bind:
- *	Check permission before socket protocol layer bind operation is
- *	performed and the socket @sock is bound to the address specified in the
- *	@address parameter.
- *	@sock contains the socket structure.
- *	@address contains the address to bind to.
- *	@addrlen contains the length of address.
- *	Return 0 if permission is granted.
- * @socket_connect:
- *	Check permission before socket protocol layer connect operation
- *	attempts to connect socket @sock to a remote address, @address.
- *	@sock contains the socket structure.
- *	@address contains the address of remote endpoint.
- *	@addrlen contains the length of address.
- *	Return 0 if permission is granted.
- * @socket_listen:
- *	Check permission before socket protocol layer listen operation.
- *	@sock contains the socket structure.
- *	@backlog contains the maximum length for the pending connection queue.
- *	Return 0 if permission is granted.
- * @socket_accept:
- *	Check permission before accepting a new connection.  Note that the new
- *	socket, @newsock, has been created and some information copied to it,
- *	but the accept operation has not actually been performed.
- *	@sock contains the listening socket structure.
- *	@newsock contains the newly created server socket for connection.
- *	Return 0 if permission is granted.
- * @socket_sendmsg:
- *	Check permission before transmitting a message to another socket.
- *	@sock contains the socket structure.
- *	@msg contains the message to be transmitted.
- *	@size contains the size of message.
- *	Return 0 if permission is granted.
- * @socket_recvmsg:
- *	Check permission before receiving a message from a socket.
- *	@sock contains the socket structure.
- *	@msg contains the message structure.
- *	@size contains the size of message structure.
- *	@flags contains the operational flags.
- *	Return 0 if permission is granted.
- * @socket_getsockname:
- *	Check permission before the local address (name) of the socket object
- *	@sock is retrieved.
- *	@sock contains the socket structure.
- *	Return 0 if permission is granted.
- * @socket_getpeername:
- *	Check permission before the remote address (name) of a socket object
- *	@sock is retrieved.
- *	@sock contains the socket structure.
- *	Return 0 if permission is granted.
- * @socket_getsockopt:
- *	Check permissions before retrieving the options associated with socket
- *	@sock.
- *	@sock contains the socket structure.
- *	@level contains the protocol level to retrieve option from.
- *	@optname contains the name of option to retrieve.
- *	Return 0 if permission is granted.
- * @socket_setsockopt:
- *	Check permissions before setting the options associated with socket
- *	@sock.
- *	@sock contains the socket structure.
- *	@level contains the protocol level to set options for.
- *	@optname contains the name of the option to set.
- *	Return 0 if permission is granted.
- * @socket_shutdown:
- *	Checks permission before all or part of a connection on the socket
- *	@sock is shut down.
- *	@sock contains the socket structure.
- *	@how contains the flag indicating how future sends and receives
- *	are handled.
- *	Return 0 if permission is granted.
- * @socket_sock_rcv_skb:
- *	Check permissions on incoming network packets.  This hook is distinct
- *	from Netfilter's IP input hooks since it is the first time that the
- *	incoming sk_buff @skb has been associated with a particular socket, @sk.
- *	Must not sleep inside this hook because some callers hold spinlocks.
- *	@sk contains the sock (not socket) associated with the incoming sk_buff.
- *	@skb contains the incoming network data.
- *	Return 0 if permission is granted.
- * @socket_getpeersec_stream:
- *	This hook allows the security module to provide peer socket security
- *	state for unix or connected tcp sockets to userspace via getsockopt
- *	SO_GETPEERSEC.  For tcp sockets this can be meaningful if the
- *	socket is associated with an ipsec SA.
- *	@sock is the local socket.
- *	@optval memory where the security state is to be copied.
- *	@optlen memory where the module should copy the actual length
- *	of the security state.
- *	@len as input is the maximum length to copy to userspace provided
- *	by the caller.
- *	Return 0 if all is well, otherwise, typical getsockopt return
- *	values.
- * @socket_getpeersec_dgram:
- *	This hook allows the security module to provide peer socket security
- *	state for udp sockets on a per-packet basis to userspace via
- *	getsockopt SO_GETPEERSEC. The application must first have indicated
- *	the IP_PASSSEC option via getsockopt. It can then retrieve the
- *	security state returned by this hook for a packet via the SCM_SECURITY
- *	ancillary message type.
- *	@sock contains the peer socket. May be NULL.
- *	@skb is the sk_buff for the packet being queried. May be NULL.
- *	@secid pointer to store the secid of the packet.
- *	Return 0 on success, error on failure.
- * @sk_alloc_security:
- *	Allocate and attach a security structure to the sk->sk_security field,
- *	which is used to copy security attributes between local stream sockets.
- *	Return 0 on success, error on failure.
- * @sk_free_security:
- *	Deallocate security structure.
- * @sk_clone_security:
- *	Clone/copy security structure.
- * @sk_getsecid:
- *	Retrieve the LSM-specific secid for the sock to enable caching
- *	of network authorizations.
- * @sock_graft:
- *	Sets the socket's isec sid to the sock's sid.
- * @inet_conn_request:
- *	Sets the openreq's sid to socket's sid with MLS portion taken
- *	from peer sid.
- *	Return 0 if permission is granted.
- * @inet_csk_clone:
- *	Sets the new child socket's sid to the openreq sid.
- * @inet_conn_established:
- *	Sets the connection's peersid to the secmark on skb.
- * @secmark_relabel_packet:
- *	Check if the process should be allowed to relabel packets to
- *	the given secid.
- *	Return 0 if permission is granted.
- * @secmark_refcount_inc:
- *	Tells the LSM to increment the number of secmark labeling rules loaded.
- * @secmark_refcount_dec:
- *	Tells the LSM to decrement the number of secmark labeling rules loaded.
- * @req_classify_flow:
- *	Sets the flow's sid to the openreq sid.
- * @tun_dev_alloc_security:
- *	This hook allows a module to allocate a security structure for a TUN
- *	device.
- *	@security pointer to a security structure pointer.
- *	Returns a zero on success, negative values on failure.
- * @tun_dev_free_security:
- *	This hook allows a module to free the security structure for a TUN
- *	device.
- *	@security pointer to the TUN device's security structure.
- * @tun_dev_create:
- *	Check permissions prior to creating a new TUN device.
- *	Return 0 if permission is granted.
- * @tun_dev_attach_queue:
- *	Check permissions prior to attaching to a TUN device queue.
- *	@security pointer to the TUN device's security structure.
- *	Return 0 if permission is granted.
- * @tun_dev_attach:
- *	This hook can be used by the module to update any security state
- *	associated with the TUN device's sock structure.
- *	@sk contains the existing sock structure.
- *	@security pointer to the TUN device's security structure.
- *	Return 0 if permission is granted.
- * @tun_dev_open:
- *	This hook can be used by the module to update any security state
- *	associated with the TUN device's security structure.
- *	@security pointer to the TUN devices's security structure.
- *	Return 0 if permission is granted.
- *
  * Security hooks for SCTP
  *
  * @sctp_assoc_request:
diff --git a/security/security.c b/security/security.c
index 6fb279f0cd50..844670d7754f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3607,11 +3607,40 @@ int security_unix_may_send(struct socket *sock,  struct socket *other)
 }
 EXPORT_SYMBOL(security_unix_may_send);
 
+/**
+ * security_socket_create() - Check if creating a new socket is allowed
+ * @family: protocol family
+ * @type: communications type
+ * @protocol: requested protocol
+ * @kern: set to 1 if a kernel socket is requested
+ *
+ * Check permissions prior to creating a new socket.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_socket_create(int family, int type, int protocol, int kern)
 {
 	return call_int_hook(socket_create, 0, family, type, protocol, kern);
 }
 
+/**
+ * security_socket_create() - Initialize a newly created socket
+ * @sock: socket
+ * @family: protocol family
+ * @type: communications type
+ * @protocol: requested protocol
+ * @kern: set to 1 if a kernel socket is requested
+ *
+ * This hook allows a module to update or allocate a per-socket security
+ * structure. Note that the security field was not added directly to the socket
+ * structure, but rather, the socket security information is stored in the
+ * associated inode.  Typically, the inode alloc_security hook will allocate
+ * and attach security information to SOCK_INODE(sock)->i_security.  This hook
+ * may be used to update the SOCK_INODE(sock)->i_security field with additional
+ * information that wasn't available when the inode was allocated.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_socket_post_create(struct socket *sock, int family,
 				int type, int protocol, int kern)
 {
@@ -3619,74 +3648,223 @@ int security_socket_post_create(struct socket *sock, int family,
 						protocol, kern);
 }
 
+/**
+ * security_socket_socketpair() - Check if creating a socketpair is allowed
+ * @socka: first socket
+ * @sockb: second socket
+ *
+ * Check permissions before creating a fresh pair of sockets.
+ *
+ * Return: Returns 0 if permission is granted and the connection was
+ *         established.
+ */
 int security_socket_socketpair(struct socket *socka, struct socket *sockb)
 {
 	return call_int_hook(socket_socketpair, 0, socka, sockb);
 }
 EXPORT_SYMBOL(security_socket_socketpair);
 
+/**
+ * security_socket_bind() - Check if a socket bind operation is allowed
+ * @sock: socket
+ * @address: requested bind address
+ * @addrlen: length of address
+ *
+ * Check permission before socket protocol layer bind operation is performed
+ * and the socket @sock is bound to the address specified in the @address
+ * parameter.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
 {
 	return call_int_hook(socket_bind, 0, sock, address, addrlen);
 }
 
+/**
+ * security_socket_connect() - Check if a socket connect operation is allowed
+ * @sock: socket
+ * @address: address of remote connection point
+ * @addrlen: length of address
+ *
+ * Check permission before socket protocol layer connect operation attempts to
+ * connect socket @sock to a remote address, @address.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_socket_connect(struct socket *sock, struct sockaddr *address, int addrlen)
 {
 	return call_int_hook(socket_connect, 0, sock, address, addrlen);
 }
 
+/**
+ * security_socket_listen() - Check if a socket is allowed to listen
+ * @sock: socket
+ * @backlog: connection queue size
+ *
+ * Check permission before socket protocol layer listen operation.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_socket_listen(struct socket *sock, int backlog)
 {
 	return call_int_hook(socket_listen, 0, sock, backlog);
 }
 
+/**
+ * security_socket_accept() - Check if a socket is allowed to accept connections
+ * @sock: listening socket
+ * @newsock: newly creation connection socket
+ *
+ * Check permission before accepting a new connection.  Note that the new
+ * socket, @newsock, has been created and some information copied to it, but
+ * the accept operation has not actually been performed.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_socket_accept(struct socket *sock, struct socket *newsock)
 {
 	return call_int_hook(socket_accept, 0, sock, newsock);
 }
 
+/**
+ * security_socket_sendmsg() - Check is sending a message is allowed
+ * @sock: sending socket
+ * @msg: message to send
+ * @size: size of message
+ *
+ * Check permission before transmitting a message to another socket.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_socket_sendmsg(struct socket *sock, struct msghdr *msg, int size)
 {
 	return call_int_hook(socket_sendmsg, 0, sock, msg, size);
 }
 
+/**
+ * security_socket_recvmsg() - Check if receiving a message is allowed
+ * @sock: receiving socket
+ * @msg: message to receive
+ * @size: size of message
+ * @flags: operational flags
+ *
+ * Check permission before receiving a message from a socket.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_socket_recvmsg(struct socket *sock, struct msghdr *msg,
 			    int size, int flags)
 {
 	return call_int_hook(socket_recvmsg, 0, sock, msg, size, flags);
 }
 
+/**
+ * security_socket_getsockname() - Check if reading the socket addr is allowed
+ * @sock: socket
+ *
+ * Check permission before reading the local address (name) of the socket
+ * object.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_socket_getsockname(struct socket *sock)
 {
 	return call_int_hook(socket_getsockname, 0, sock);
 }
 
+/**
+ * security_socket_getpeername() - Check if reading the peer's addr is allowed
+ * @sock: socket
+ *
+ * Check permission before the remote address (name) of a socket object.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_socket_getpeername(struct socket *sock)
 {
 	return call_int_hook(socket_getpeername, 0, sock);
 }
 
+/**
+ * security_socket_getsockopt() - Check if reading a socket option is allowed
+ * @sock: socket
+ * @level: option's protocol level
+ * @optname: option name
+ *
+ * Check permissions before retrieving the options associated with socket
+ * @sock.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_socket_getsockopt(struct socket *sock, int level, int optname)
 {
 	return call_int_hook(socket_getsockopt, 0, sock, level, optname);
 }
 
+/**
+ * security_socket_setsockopt() - Check if setting a socket option is allowed
+ * @sock: socket
+ * @level: option's protocol level
+ * @optname: option name
+ *
+ * Check permissions before setting the options associated with socket @sock.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_socket_setsockopt(struct socket *sock, int level, int optname)
 {
 	return call_int_hook(socket_setsockopt, 0, sock, level, optname);
 }
 
+/**
+ * security_socket_shutdown() - Checks if shutting down the socket is allowed
+ * @sock: socket
+ * @how: flag indicating how sends and receives are handled
+ *
+ * Checks permission before all or part of a connection on the socket @sock is
+ * shut down.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_socket_shutdown(struct socket *sock, int how)
 {
 	return call_int_hook(socket_shutdown, 0, sock, how);
 }
 
+/**
+ * security_sock_rcv_skb() - Check if an incoming network packet is allowed
+ * @sk: destination sock
+ * @skb: incoming packet
+ *
+ * Check permissions on incoming network packets.  This hook is distinct from
+ * Netfilter's IP input hooks since it is the first time that the incoming
+ * sk_buff @skb has been associated with a particular socket, @sk.  Must not
+ * sleep inside this hook because some callers hold spinlocks.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
 	return call_int_hook(socket_sock_rcv_skb, 0, sk, skb);
 }
 EXPORT_SYMBOL(security_sock_rcv_skb);
 
+/**
+ * security_socket_getpeersec_stream() - Get the remote peer label
+ * @sock: socket
+ * @optval: destination buffer
+ * @optlen: size of peer label copied into the buffer
+ * @len: maximum size of the destination buffer
+ *
+ * This hook allows the security module to provide peer socket security state
+ * for unix or connected tcp sockets to userspace via getsockopt SO_GETPEERSEC.
+ * For tcp sockets this can be meaningful if the socket is associated with an
+ * ipsec SA.
+ *
+ * Return: Returns 0 if all is well, otherwise, typical getsockopt return
+ *         values.
+ */
 int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
 				      sockptr_t optlen, unsigned int len)
 {
@@ -3694,6 +3872,20 @@ int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
 			     optval, optlen, len);
 }
 
+/**
+ * security_socket_getpeersec_dgram() - Get the remote peer label
+ * @sock: socket
+ * @skb: datagram packet
+ * @secid: remote peer label secid
+ *
+ * This hook allows the security module to provide peer socket security state
+ * for udp sockets on a per-packet basis to userspace via getsockopt
+ * SO_GETPEERSEC. The application must first have indicated the IP_PASSSEC
+ * option via getsockopt. It can then retrieve the security state returned by
+ * this hook for a packet via the SCM_SECURITY ancillary message type.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
 {
 	return call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock,
@@ -3701,16 +3893,40 @@ int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
+/**
+ * security_sk_alloc() - Allocate and initialize a sock's LSM blob
+ * @sk: sock
+ * @family: protocol family
+ * @priotity: gfp flags
+ *
+ * Allocate and attach a security structure to the sk->sk_security field, which
+ * is used to copy security attributes between local stream sockets.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority)
 {
 	return call_int_hook(sk_alloc_security, 0, sk, family, priority);
 }
 
+/**
+ * security_sk_free() - Free the sock's LSM blob
+ * @sk: sock
+ *
+ * Deallocate security structure.
+ */
 void security_sk_free(struct sock *sk)
 {
 	call_void_hook(sk_free_security, sk);
 }
 
+/**
+ * security_sk_clone() - Clone a sock's LSM state
+ * @sk: original sock
+ * @newsk: target sock
+ *
+ * Clone/copy security structure.
+ */
 void security_sk_clone(const struct sock *sk, struct sock *newsk)
 {
 	call_void_hook(sk_clone_security, sk, newsk);
@@ -3723,6 +3939,13 @@ void security_sk_classify_flow(struct sock *sk, struct flowi_common *flic)
 }
 EXPORT_SYMBOL(security_sk_classify_flow);
 
+/**
+ * security_req_classify_flow() - Set a flow's secid based on request_sock
+ * @req: request_sock
+ * @flic: target flow
+ *
+ * Sets @flic's secid to @req's secid.
+ */
 void security_req_classify_flow(const struct request_sock *req,
 				struct flowi_common *flic)
 {
@@ -3730,12 +3953,30 @@ void security_req_classify_flow(const struct request_sock *req,
 }
 EXPORT_SYMBOL(security_req_classify_flow);
 
+/**
+ * security_sock_graft() - Reconcile LSM state when grafting a sock on a socket
+ * @sk: sock being grafted
+ * @sock: target socket
+ *
+ * Sets @sock's inode secid to @sk's secid and update @sk with any necessary
+ * LSM state from @sock.
+ */
 void security_sock_graft(struct sock *sk, struct socket *parent)
 {
 	call_void_hook(sock_graft, sk, parent);
 }
 EXPORT_SYMBOL(security_sock_graft);
 
+/**
+ * security_inet_conn_request() - Set request_sock state using incoming connect
+ * @sk: parent listening sock
+ * @skb: incoming connection
+ * @req: new request_sock
+ *
+ * Initialize the @req LSM state based on @sk and the incoming connect in @skb.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_inet_conn_request(const struct sock *sk,
 			struct sk_buff *skb, struct request_sock *req)
 {
@@ -3743,12 +3984,26 @@ int security_inet_conn_request(const struct sock *sk,
 }
 EXPORT_SYMBOL(security_inet_conn_request);
 
+/**
+ * security_inet_csk_clone() - Set new sock LSM state based on request_sock
+ * @newsk: new sock
+ * @req: connection request_sock
+ *
+ * Set that LSM state of @sock using the LSM state from @req.
+ */
 void security_inet_csk_clone(struct sock *newsk,
 			const struct request_sock *req)
 {
 	call_void_hook(inet_csk_clone, newsk, req);
 }
 
+/**
+ * security_inet_conn_established() - Update sock's LSM state with connection
+ * @sk: sock
+ * @skb: connection packet
+ *
+ * Update @sock's LSM state to represent a new connection from @skb.
+ */
 void security_inet_conn_established(struct sock *sk,
 			struct sk_buff *skb)
 {
@@ -3756,54 +4011,121 @@ void security_inet_conn_established(struct sock *sk,
 }
 EXPORT_SYMBOL(security_inet_conn_established);
 
+/**
+ * security_secmark_relabel_packet() - Check if setting a secmark is allowed
+ * @secid: new secmark value
+ *
+ * Check if the process should be allowed to relabel packets to @secid.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_secmark_relabel_packet(u32 secid)
 {
 	return call_int_hook(secmark_relabel_packet, 0, secid);
 }
 EXPORT_SYMBOL(security_secmark_relabel_packet);
 
+/**
+ * security_secmark_refcount_inc() - Increment the secmark labeling rule count
+ *
+ * Tells the LSM to increment the number of secmark labeling rules loaded.
+ */
 void security_secmark_refcount_inc(void)
 {
 	call_void_hook(secmark_refcount_inc);
 }
 EXPORT_SYMBOL(security_secmark_refcount_inc);
 
+/**
+ * security_secmark_refcount_dec() - Decrement the secmark labeling rule count
+ *
+ * Tells the LSM to decrement the number of secmark labeling rules loaded.
+ */
 void security_secmark_refcount_dec(void)
 {
 	call_void_hook(secmark_refcount_dec);
 }
 EXPORT_SYMBOL(security_secmark_refcount_dec);
 
+/**
+ * security_tun_dev_alloc_security() - Allocate a LSM blob for a TUN device
+ * @security: pointer to the LSM blob
+ *
+ * This hook allows a module to allocate a security structure for a TUN	device,
+ * returning the pointer in @security.
+ *
+ * Return: Returns a zero on success, negative values on failure.
+ */
 int security_tun_dev_alloc_security(void **security)
 {
 	return call_int_hook(tun_dev_alloc_security, 0, security);
 }
 EXPORT_SYMBOL(security_tun_dev_alloc_security);
 
+/**
+ * security_tun_dev_free_security() - Free a TUN device LSM blob
+ * @security: LSM blob
+ *
+ * This hook allows a module to free the security structure for a TUN device.
+ */
 void security_tun_dev_free_security(void *security)
 {
 	call_void_hook(tun_dev_free_security, security);
 }
 EXPORT_SYMBOL(security_tun_dev_free_security);
 
+/**
+ * security_tun_dev_create() - Check if creating a TUN device is allowed
+ *
+ * Check permissions prior to creating a new TUN device.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_tun_dev_create(void)
 {
 	return call_int_hook(tun_dev_create, 0);
 }
 EXPORT_SYMBOL(security_tun_dev_create);
 
+/**
+ * security_tun_dev_attach_queue() - Check if attaching a TUN queue is allowed
+ * @security: TUN device LSM blob
+ *
+ * Check permissions prior to attaching to a TUN device queue.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_tun_dev_attach_queue(void *security)
 {
 	return call_int_hook(tun_dev_attach_queue, 0, security);
 }
 EXPORT_SYMBOL(security_tun_dev_attach_queue);
 
+/**
+ * security_tun_dev_attach() - Update TUN device LSM state on attach
+ * @sk: associated sock
+ * @security: TUN device LSM blob
+ *
+ * This hook can be used by the module to update any security state associated
+ * with the TUN device's sock structure.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_tun_dev_attach(struct sock *sk, void *security)
 {
 	return call_int_hook(tun_dev_attach, 0, sk, security);
 }
 EXPORT_SYMBOL(security_tun_dev_attach);
 
+/**
+ * security_tun_dev_open() - Update TUN device LSM state on open
+ * @security: TUN device LSM blob
+ *
+ * This hook can be used by the module to update any security state associated
+ * with the TUN device's security structure.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_tun_dev_open(void *security)
 {
 	return call_int_hook(tun_dev_open, 0, security);
-- 
2.39.2

