From: casey@schaufler-ca.com (Casey Schaufler)
Date: Thu, 5 Oct 2017 17:47:02 -0700
Subject: [PATCH v2] Smack: More sanity in the use of Netlabel
Message-ID: <41cf9d25-c840-6afd-8633-7e855eb24b40@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Change the basic Smack networking configuration to use
address specifiers instead of netlabel "domains". This
has two major advantages. It is much better in keeping
with the way networks are typically configured. Very
few networks use CIPSO as a general mechanism. It also
simplifies the behavior of the "ambient" network label
by assigning it to unlabeled hosts rather than defining
that packets associated with that Smack label be sent
unlabeled.

If you want to use CIPSO on all interfaces by default
you can. There's a configuration option
SECURITY_SMACK_ALLCIPSO that initializes 0.0.0.0/0 to
CIPSO instead of unlabeled.

The only drawback, as pointed out by the Samsung Tizen
team, is that the local interfaces will be unlabeled.
This script will set the local interfaces to use CIPSO.
The script will be submitted to the Smack user-space
project under separate cover.

  #! /bin/sh
  # 
  # Copyright (c) 2017 Intel Corporation
  # 
  # Permission is hereby granted, free of charge, to any person
  # obtaining a copy of this software and associated documentation
  # files (the "Software"), to deal in the Software without restriction,
  # including without limitation the rights to use, copy, modify, merge,
  # publish, distribute, sublicense, and/or sell copies of the Software,
  # and to permit persons to whom the Software is furnished to do so,
  # subject to the following conditions:
  # 
  # The above copyright notice and this permission notice shall be
  # included in all copies or substantial portions of the Software.
  # 
  # THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
  # EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
  # OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
  # NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
  # BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
  # ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
  # CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  # SOFTWARE.
  # 
  
  SMACKNET=/sys/fs/smackfs/netlabel
  IFCONFIG=/usr/sbin/ifconfig
  
  for i in `$IFCONFIG | \
  	grep '^[ \i][ \i]*inet ' | grep -v 127.0.0.1 | \
  	sed -e 's/[^ \i]*inet \([^ ]*\) .*/\1/'`
  do
  	echo $i -CIPSO > $SMACKNET
  done

Use of the netlabel cache mechanism is not included at
this stage, but is planned for the near future.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/Kconfig           |  24 +++-
 security/smack/Makefile          |   3 +-
 security/smack/smack.h           |  24 ++--
 security/smack/smack_access.c    |   6 +-
 security/smack/smack_lsm.c       | 272 +++++++++++++++++++++++----------------
 security/smack/smack_netfilter.c |   4 +-
 security/smack/smackfs.c         | 223 ++++++++++++++++++++------------
 7 files changed, 339 insertions(+), 217 deletions(-)

diff --git a/security/smack/Kconfig b/security/smack/Kconfig
index 923b120e0fa5..f41f4dcbd175 100644
--- a/security/smack/Kconfig
+++ b/security/smack/Kconfig
@@ -5,6 +5,8 @@ config SECURITY_SMACK
 	depends on SECURITY
 	select NETLABEL
 	select SECURITY_NETWORK
+	select NETWORK_SECMARK
+	select NETFILTER
 	default n
 	help
 	  This selects the Simplified Mandatory Access Control Kernel.
@@ -31,15 +33,13 @@ config SECURITY_SMACK_BRINGUP
 	  If you are unsure how to answer this question, answer N.
 
 config SECURITY_SMACK_NETFILTER
-	bool "Packet marking using secmarks for netfilter"
+	bool "IPv6 packet marking using secmarks for netfilter"
 	depends on SECURITY_SMACK
-	depends on NETWORK_SECMARK
-	depends on NETFILTER
-	default n
+	default y
 	help
 	  This enables security marking of network packets using
 	  Smack labels.
-	  If you are unsure how to answer this question, answer N.
+	  If you are unsure how to answer this question, answer Y.
 
 config SECURITY_SMACK_APPEND_SIGNALS
 	bool "Treat delivering signals as an append operation"
@@ -52,3 +52,17 @@ config SECURITY_SMACK_APPEND_SIGNALS
 	  to differentiate between delivering a network packet and
 	  delivering a signal in the Smack rules.
 	  If you are unsure how to answer this question, answer N.
+
+config SECURITY_SMACK_ALLCIPSO
+	bool "Use CIPSO packet labeling for all IPv4 traffic"
+	depends on SECURITY_SMACK
+	default n
+	help
+	  Configure use of the CIPSO IPv4 option for all addresses.
+	  If this is not set CIPSO will only be used for the loopback
+	  address 127.0.0.1 at system initialization. This option is
+	  provided for legacy installations. Few real world situations
+	  use networks of CIPSO enabled systems. A system that does
+	  not set this option should configure local interfaces to
+	  use CIPSO after the interfaces are activated.
+	  If you are unsure how to answer this question, answer N.
diff --git a/security/smack/Makefile b/security/smack/Makefile
index ee2ebd504541..63077c9c1dfe 100644
--- a/security/smack/Makefile
+++ b/security/smack/Makefile
@@ -4,5 +4,4 @@
 
 obj-$(CONFIG_SECURITY_SMACK) := smack.o
 
-smack-y := smack_lsm.o smack_access.o smackfs.o
-smack-$(CONFIG_SECURITY_SMACK_NETFILTER) += smack_netfilter.o
+smack-y := smack_lsm.o smack_access.o smackfs.o smack_netfilter.o
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 6a71fc7831ab..88c15a1f2116 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -26,18 +26,6 @@
 #include <linux/lsm_audit.h>
 
 /*
- * Use IPv6 port labeling if IPv6 is enabled and secmarks
- * are not being used.
- */
-#if IS_ENABLED(CONFIG_IPV6) && !defined(CONFIG_SECURITY_SMACK_NETFILTER)
-#define SMACK_IPV6_PORT_LABELING 1
-#endif
-
-#if IS_ENABLED(CONFIG_IPV6) && defined(CONFIG_SECURITY_SMACK_NETFILTER)
-#define SMACK_IPV6_SECMARK_LABELING 1
-#endif
-
-/*
  * Smack labels were limited to 23 characters for a long time.
  */
 #define SMK_LABELLEN	24
@@ -103,7 +91,15 @@ struct socket_smack {
 	struct smack_known	*smk_out;	/* outbound label */
 	struct smack_known	*smk_in;	/* inbound label */
 	struct smack_known	*smk_packet;	/* TCP peer label */
+	int			smk_state;	/* netlabel state */
 };
+/*
+ * Socket states
+ */
+#define SMK_SOCK_UNSET		0
+#define SMK_SOCK_LABELED	1
+#define SMK_SOCK_DEFERRED	2
+#define SMK_SOCK_CONNED		3
 
 /*
  * Inode smack data
@@ -164,7 +160,7 @@ struct smk_net6addr {
 };
 #endif /* CONFIG_IPV6 */
 
-#ifdef SMACK_IPV6_PORT_LABELING
+#ifndef CONFIG_SECURITY_SMACK_NETFILTER
 /*
  * An entry in the table identifying ports.
  */
@@ -177,7 +173,7 @@ struct smk_port_label {
 	short			smk_sock_type;	/* Socket type */
 	short			smk_can_reuse;
 };
-#endif /* SMACK_IPV6_PORT_LABELING */
+#endif
 
 struct smack_known_list_elem {
 	struct list_head	list;
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index 1a3004189447..4d24c00b4ea9 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -548,9 +548,11 @@ struct smack_known *smk_import_entry(const char *string, int len)
 
 	skp->smk_known = smack;
 	skp->smk_secid = smack_next_secid++;
+	skp->smk_netlabel.attr.secid = skp->smk_secid;
 	skp->smk_netlabel.domain = skp->smk_known;
-	skp->smk_netlabel.flags =
-		NETLBL_SECATTR_DOMAIN | NETLBL_SECATTR_MLS_LVL;
+	skp->smk_netlabel.flags = NETLBL_SECATTR_DOMAIN |
+				  NETLBL_SECATTR_MLS_LVL |
+				  NETLBL_SECATTR_SECID;
 	/*
 	 * If direct labeling works use it.
 	 * Otherwise use mapped labeling.
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 319add31b4a4..16ddd20c1a02 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -34,6 +34,7 @@
 #include <net/cipso_ipv4.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
+#include <net/icmp.h>
 #include <linux/audit.h>
 #include <linux/magic.h>
 #include <linux/dcache.h>
@@ -51,7 +52,7 @@
 #define SMK_RECEIVING	1
 #define SMK_SENDING	2
 
-#ifdef SMACK_IPV6_PORT_LABELING
+#ifndef CONFIG_SECURITY_SMACK_NETFILTER
 DEFINE_MUTEX(smack_ipv6_lock);
 static LIST_HEAD(smk_ipv6_port_list);
 #endif
@@ -2336,7 +2337,7 @@ static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
  */
 static void smack_sk_free_security(struct sock *sk)
 {
-#ifdef SMACK_IPV6_PORT_LABELING
+#ifndef CONFIG_SECURITY_SMACK_NETFILTER
 	struct smk_port_label *spp;
 
 	if (sk->sk_family == PF_INET6) {
@@ -2386,6 +2387,29 @@ static struct smack_known *smack_ipv4host_label(struct sockaddr_in *sip)
 	return NULL;
 }
 
+/**
+ * smack_ipv4_skb_host_label - check host based restrictions
+ * @skb: the incoming packet data
+ *
+ * looks for host based access restrictions
+ *
+ * Returns the label of the far end or NULL if it's not special.
+ */
+static struct smack_known *smack_ipv4_skb_host_label(struct sk_buff *skb)
+{
+	struct smack_known *skp;
+	struct sockaddr_in addr;
+	struct iphdr *hdr;
+
+	hdr = ip_hdr(skb);
+	addr.sin_addr.s_addr = hdr->saddr;
+
+	rcu_read_lock();
+	skp = smack_ipv4host_label(&addr);
+	rcu_read_unlock();
+	return skp;
+}
+
 #if IS_ENABLED(CONFIG_IPV6)
 /*
  * smk_ipv6_localhost - Check for local ipv6 host address
@@ -2466,29 +2490,32 @@ static struct smack_known *smack_ipv6host_label(struct sockaddr_in6 *sip)
  *
  * Returns 0 on success or an error code
  */
-static int smack_netlabel(struct sock *sk, int labeled)
+static int smack_netlabel(struct sock *sk)
 {
 	struct smack_known *skp;
 	struct socket_smack *ssp = sk->sk_security;
 	int rc = 0;
 
+	skp = ssp->smk_out;
 	/*
-	 * Usually the netlabel code will handle changing the
+	 * The netlabel code will handle changing the
 	 * packet labeling based on the label.
-	 * The case of a single label host is different, because
-	 * a single label host should never get a labeled packet
-	 * even though the label is usually associated with a packet
-	 * label.
 	 */
 	local_bh_disable();
 	bh_lock_sock_nested(sk);
 
-	if (ssp->smk_out == smack_net_ambient ||
-	    labeled == SMACK_UNLABELED_SOCKET)
-		netlbl_sock_delattr(sk);
-	else {
-		skp = ssp->smk_out;
-		rc = netlbl_sock_setattr(sk, sk->sk_family, &skp->smk_netlabel);
+	rc = netlbl_sock_setattr(sk, sk->sk_family, &skp->smk_netlabel);
+	switch (rc) {
+	case 0:
+		ssp->smk_state = SMK_SOCK_LABELED;
+		break;
+	case -EDESTADDRREQ:
+		ssp->smk_state = SMK_SOCK_DEFERRED;
+		rc = 0;
+		break;
+	default:
+		ssp->smk_state = SMK_SOCK_UNSET;
+		break;
 	}
 
 	bh_unlock_sock(sk);
@@ -2498,21 +2525,19 @@ static int smack_netlabel(struct sock *sk, int labeled)
 }
 
 /**
- * smack_netlbel_send - Set the secattr on a socket and perform access checks
+ * smack_host_check - Perform access checks
  * @sk: the socket
  * @sap: the destination address
  *
- * Set the correct secattr for the given socket based on the destination
- * address and perform any outbound access checks needed.
+ * Perform any outbound access checks needed.
  *
  * Returns 0 on success or an error code.
  *
  */
-static int smack_netlabel_send(struct sock *sk, struct sockaddr_in *sap)
+static int smack_host_check(struct sock *sk, struct sockaddr_in *sap)
 {
 	struct smack_known *skp;
-	int rc;
-	int sk_lbl;
+	int rc = 0;
 	struct smack_known *hkp;
 	struct socket_smack *ssp = sk->sk_security;
 	struct smk_audit_info ad;
@@ -2528,19 +2553,12 @@ static int smack_netlabel_send(struct sock *sk, struct sockaddr_in *sap)
 		ad.a.u.net->dport = sap->sin_port;
 		ad.a.u.net->v4info.daddr = sap->sin_addr.s_addr;
 #endif
-		sk_lbl = SMACK_UNLABELED_SOCKET;
 		skp = ssp->smk_out;
 		rc = smk_access(skp, hkp, MAY_WRITE, &ad);
 		rc = smk_bu_note("IPv4 host check", skp, hkp, MAY_WRITE, rc);
-	} else {
-		sk_lbl = SMACK_CIPSO_SOCKET;
-		rc = 0;
 	}
 	rcu_read_unlock();
-	if (rc != 0)
-		return rc;
-
-	return smack_netlabel(sk, sk_lbl);
+	return rc;
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -2578,7 +2596,7 @@ static int smk_ipv6_check(struct smack_known *subject,
 }
 #endif /* CONFIG_IPV6 */
 
-#ifdef SMACK_IPV6_PORT_LABELING
+#ifndef CONFIG_SECURITY_SMACK_NETFILTER
 /**
  * smk_ipv6_port_label - Smack port access table management
  * @sock: socket
@@ -2726,7 +2744,7 @@ static int smk_ipv6_port_check(struct sock *sk, struct sockaddr_in6 *address,
 
 	return smk_ipv6_check(skp, object, address, act);
 }
-#endif /* SMACK_IPV6_PORT_LABELING */
+#endif /* !CONFIG_SECURITY_SMACK_NETFILTER */
 
 /**
  * smack_inode_setsecurity - set smack xattrs
@@ -2778,16 +2796,16 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 	else if (strcmp(name, XATTR_SMACK_IPOUT) == 0) {
 		ssp->smk_out = skp;
 		if (sock->sk->sk_family == PF_INET) {
-			rc = smack_netlabel(sock->sk, SMACK_CIPSO_SOCKET);
+			rc = smack_netlabel(sock->sk);
 			if (rc != 0)
-				printk(KERN_WARNING
-					"Smack: \"%s\" netlbl error %d.\n",
-					__func__, -rc);
+				pr_warn(
+				    "Smack: \"%s\" netlbl error %d.\n",
+				    __func__, -rc);
 		}
 	} else
 		return -EOPNOTSUPP;
 
-#ifdef SMACK_IPV6_PORT_LABELING
+#ifndef CONFIG_SECURITY_SMACK_NETFILTER
 	if (sock->sk->sk_family == PF_INET6)
 		smk_ipv6_port_label(sock, NULL);
 #endif
@@ -2815,11 +2833,11 @@ static int smack_socket_post_create(struct socket *sock, int family,
 	if (sock->sk == NULL)
 		return 0;
 
+	ssp = sock->sk->sk_security;
 	/*
 	 * Sockets created by kernel threads receive web label.
 	 */
 	if (unlikely(current->flags & PF_KTHREAD)) {
-		ssp = sock->sk->sk_security;
 		ssp->smk_in = &smack_known_web;
 		ssp->smk_out = &smack_known_web;
 	}
@@ -2829,10 +2847,10 @@ static int smack_socket_post_create(struct socket *sock, int family,
 	/*
 	 * Set the outbound netlbl.
 	 */
-	return smack_netlabel(sock->sk, SMACK_CIPSO_SOCKET);
+	return smack_netlabel(sock->sk);
 }
 
-#ifdef SMACK_IPV6_PORT_LABELING
+#ifndef CONFIG_SECURITY_SMACK_NETFILTER
 /**
  * smack_socket_bind - record port binding information.
  * @sock: the socket
@@ -2850,7 +2868,7 @@ static int smack_socket_bind(struct socket *sock, struct sockaddr *address,
 		smk_ipv6_port_label(sock, address);
 	return 0;
 }
-#endif /* SMACK_IPV6_PORT_LABELING */
+#endif /* !CONFIG_SECURITY_SMACK_NETFILTER */
 
 /**
  * smack_socket_connect - connect access check
@@ -2866,37 +2884,59 @@ static int smack_socket_connect(struct socket *sock, struct sockaddr *sap,
 				int addrlen)
 {
 	int rc = 0;
+	struct sock *sk = sock->sk;
+	struct socket_smack *ssp;
 #if IS_ENABLED(CONFIG_IPV6)
 	struct sockaddr_in6 *sip = (struct sockaddr_in6 *)sap;
 #endif
-#ifdef SMACK_IPV6_SECMARK_LABELING
+#ifdef CONFIG_SECURITY_SMACK_NETFILTER
 	struct smack_known *rsp;
-	struct socket_smack *ssp = sock->sk->sk_security;
 #endif
 
-	if (sock->sk == NULL)
+	if (sk == NULL)
 		return 0;
 
+	ssp = sk->sk_security;
+	lock_sock(sk);
+
+	if (sap->sa_family == AF_UNSPEC) {
+		netlbl_sock_delattr(sk);
+		ssp->smk_state = SMK_SOCK_DEFERRED;
+		goto release_out;
+	}
+
 	switch (sock->sk->sk_family) {
 	case PF_INET:
-		if (addrlen < sizeof(struct sockaddr_in))
-			return -EINVAL;
-		rc = smack_netlabel_send(sock->sk, (struct sockaddr_in *)sap);
+		if (addrlen < sizeof(struct sockaddr_in)) {
+			rc = -EINVAL;
+			break;
+		}
+		rc = smack_host_check(sock->sk, (struct sockaddr_in *)sap);
+		if (rc)
+			break;
+		rc = netlbl_conn_setattr(sock->sk, sap,
+					&ssp->smk_out->smk_netlabel);
+		if (rc == 0)
+			ssp->smk_state = SMK_SOCK_CONNED;
 		break;
 	case PF_INET6:
-		if (addrlen < sizeof(struct sockaddr_in6))
-			return -EINVAL;
-#ifdef SMACK_IPV6_SECMARK_LABELING
+		if (addrlen < sizeof(struct sockaddr_in6)) {
+			rc = -EINVAL;
+			break;
+		}
+#ifdef CONFIG_SECURITY_SMACK_NETFILTER
 		rsp = smack_ipv6host_label(sip);
 		if (rsp != NULL)
 			rc = smk_ipv6_check(ssp->smk_out, rsp, sip,
 						SMK_CONNECTING);
-#endif
-#ifdef SMACK_IPV6_PORT_LABELING
+#else
 		rc = smk_ipv6_port_check(sock->sk, sip, SMK_CONNECTING);
 #endif
 		break;
 	}
+
+release_out:
+	release_sock(sk);
 	return rc;
 }
 
@@ -3794,11 +3834,11 @@ static int smack_socket_sendmsg(struct socket *sock, struct msghdr *msg,
 	struct sockaddr_in *sip = (struct sockaddr_in *) msg->msg_name;
 #if IS_ENABLED(CONFIG_IPV6)
 	struct sockaddr_in6 *sap = (struct sockaddr_in6 *) msg->msg_name;
-#endif
-#ifdef SMACK_IPV6_SECMARK_LABELING
+#ifdef CONFIG_SECURITY_SMACK_NETFILTER
 	struct socket_smack *ssp = sock->sk->sk_security;
 	struct smack_known *rsp;
 #endif
+#endif
 	int rc = 0;
 
 	/*
@@ -3809,16 +3849,19 @@ static int smack_socket_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	switch (sock->sk->sk_family) {
 	case AF_INET:
-		rc = smack_netlabel_send(sock->sk, sip);
+		/*
+		 * If going to a single label host do the check here.
+		 * Otherwise there's nothing to do.
+		 */
+		rc = smack_host_check(sock->sk, sip);
 		break;
 	case AF_INET6:
-#ifdef SMACK_IPV6_SECMARK_LABELING
+#ifdef CONFIG_SECURITY_SMACK_NETFILTER
 		rsp = smack_ipv6host_label(sap);
 		if (rsp != NULL)
 			rc = smk_ipv6_check(ssp->smk_out, rsp, sap,
 						SMK_CONNECTING);
-#endif
-#ifdef SMACK_IPV6_PORT_LABELING
+#else
 		rc = smk_ipv6_port_check(sock->sk, sap, SMK_SENDING);
 #endif
 		break;
@@ -3837,10 +3880,16 @@ static struct smack_known *smack_from_secattr(struct netlbl_lsm_secattr *sap,
 						struct socket_smack *ssp)
 {
 	struct smack_known *skp;
-	int found = 0;
+	bool found = false;
 	int acat;
 	int kcat;
 
+	if ((sap->flags & NETLBL_SECATTR_SECID) != 0)
+		/*
+		 * Looks like a fallback, which gives us a secid.
+		 */
+		return smack_from_secid(sap->attr.secid);
+
 	if ((sap->flags & NETLBL_SECATTR_MLS_LVL) != 0) {
 		/*
 		 * Looks like a CIPSO packet.
@@ -3862,7 +3911,7 @@ static struct smack_known *smack_from_secattr(struct netlbl_lsm_secattr *sap,
 			if ((sap->flags & NETLBL_SECATTR_MLS_CAT) == 0) {
 				if ((skp->smk_netlabel.flags &
 				     NETLBL_SECATTR_MLS_CAT) == 0)
-					found = 1;
+					found = true;
 				break;
 			}
 			for (acat = -1, kcat = -1; acat == kcat; ) {
@@ -3875,7 +3924,7 @@ static struct smack_known *smack_from_secattr(struct netlbl_lsm_secattr *sap,
 					break;
 			}
 			if (acat == kcat) {
-				found = 1;
+				found = true;
 				break;
 			}
 		}
@@ -3884,15 +3933,11 @@ static struct smack_known *smack_from_secattr(struct netlbl_lsm_secattr *sap,
 		if (found)
 			return skp;
 
-		if (ssp != NULL && ssp->smk_in == &smack_known_star)
+		if (ssp && (ssp->smk_in == &smack_known_star ||
+			    ssp->smk_in == &smack_known_web))
 			return &smack_known_web;
 		return &smack_known_star;
 	}
-	if ((sap->flags & NETLBL_SECATTR_SECID) != 0)
-		/*
-		 * Looks like a fallback, which gives us a secid.
-		 */
-		return smack_from_secid(sap->attr.secid);
 	/*
 	 * Without guidance regarding the smack value
 	 * for the packet fall back on the network
@@ -3959,6 +4004,7 @@ static int smk_skb_to_addr_ipv6(struct sk_buff *skb, struct sockaddr_in6 *sip)
  */
 static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
+	bool by_host = false;
 	struct netlbl_lsm_secattr secattr;
 	struct socket_smack *ssp = sk->sk_security;
 	struct smack_known *skp = NULL;
@@ -3969,22 +4015,29 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 #endif
 #if IS_ENABLED(CONFIG_IPV6)
 	struct sockaddr_in6 sadd;
-	int proto;
 #endif /* CONFIG_IPV6 */
 
 	switch (sk->sk_family) {
 	case PF_INET:
-#ifdef CONFIG_SECURITY_SMACK_NETFILTER
+		if (!skb) {
+			skp = smack_net_ambient;
+			goto access_check;
+		}
 		/*
-		 * If there is a secmark use it rather than the CIPSO label.
-		 * If there is no secmark fall back to CIPSO.
-		 * The secmark is assumed to reflect policy better.
+		 * A secmark indicates that netfilter has been invoked.
 		 */
-		if (skb && skb->secmark != 0) {
+		if (skb->secmark) {
 			skp = smack_from_secid(skb->secmark);
 			goto access_check;
 		}
-#endif /* CONFIG_SECURITY_SMACK_NETFILTER */
+		/*
+		 * If the source is a single label host use its label.
+		 */
+		skp = smack_ipv4_skb_host_label(skb);
+		if (skp) {
+			by_host = true;
+			goto access_check;
+		}
 		/*
 		 * Translate what netlabel gave us.
 		 */
@@ -3998,9 +4051,8 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 
 		netlbl_secattr_destroy(&secattr);
 
-#ifdef CONFIG_SECURITY_SMACK_NETFILTER
 access_check:
-#endif
+
 #ifdef CONFIG_AUDIT
 		smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
 		ad.a.u.net->family = sk->sk_family;
@@ -4016,15 +4068,19 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		rc = smk_access(skp, ssp->smk_in, MAY_WRITE, &ad);
 		rc = smk_bu_note("IPv4 delivery", skp, ssp->smk_in,
 					MAY_WRITE, rc);
-		if (rc != 0)
+		if (rc == 0)
+			break;
+		if (by_host)
+			icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0);
+		else
 			netlbl_skbuff_err(skb, sk->sk_family, rc, 0);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case PF_INET6:
-		proto = smk_skb_to_addr_ipv6(skb, &sadd);
-		if (proto != IPPROTO_UDP && proto != IPPROTO_TCP)
+		rc = smk_skb_to_addr_ipv6(skb, &sadd);
+		if (rc != IPPROTO_UDP && rc != IPPROTO_TCP)
 			break;
-#ifdef SMACK_IPV6_SECMARK_LABELING
+#ifdef CONFIG_SECURITY_SMACK_NETFILTER
 		if (skb && skb->secmark != 0)
 			skp = smack_from_secid(skb->secmark);
 		else
@@ -4040,10 +4096,9 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		rc = smk_access(skp, ssp->smk_in, MAY_WRITE, &ad);
 		rc = smk_bu_note("IPv6 delivery", skp, ssp->smk_in,
 					MAY_WRITE, rc);
-#endif /* SMACK_IPV6_SECMARK_LABELING */
-#ifdef SMACK_IPV6_PORT_LABELING
+#else
 		rc = smk_ipv6_port_check(sk, &sadd, SMK_RECEIVING);
-#endif /* SMACK_IPV6_PORT_LABELING */
+#endif /* CONFIG_SECURITY_SMACK_NETFILTER */
 		break;
 #endif /* CONFIG_IPV6 */
 	}
@@ -4123,11 +4178,20 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		s = ssp->smk_out->smk_secid;
 		break;
 	case PF_INET:
-#ifdef CONFIG_SECURITY_SMACK_NETFILTER
+		/*
+		 * Give highest priority to the secmark
+		 */
 		s = skb->secmark;
 		if (s != 0)
 			break;
-#endif
+		/*
+		 * Use host label if it is specified.
+		 */
+		skp = smack_ipv4_skb_host_label(skb);
+		if (skp) {
+			s = skp->smk_secid;
+			break;
+		}
 		/*
 		 * Translate what netlabel gave us.
 		 */
@@ -4142,7 +4206,7 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		netlbl_secattr_destroy(&secattr);
 		break;
 	case PF_INET6:
-#ifdef SMACK_IPV6_SECMARK_LABELING
+#ifdef CONFIG_SECURITY_SMACK_NETFILTER
 		s = skb->secmark;
 #endif
 		break;
@@ -4192,9 +4256,6 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	struct smack_known *skp;
 	struct socket_smack *ssp = sk->sk_security;
 	struct netlbl_lsm_secattr secattr;
-	struct sockaddr_in addr;
-	struct iphdr *hdr;
-	struct smack_known *hskp;
 	int rc;
 	struct smk_audit_info ad;
 #ifdef CONFIG_AUDIT
@@ -4214,8 +4275,6 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 			return 0;
 	}
 #endif /* CONFIG_IPV6 */
-
-#ifdef CONFIG_SECURITY_SMACK_NETFILTER
 	/*
 	 * If there is a secmark use it rather than the CIPSO label.
 	 * If there is no secmark fall back to CIPSO.
@@ -4225,7 +4284,10 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 		skp = smack_from_secid(skb->secmark);
 		goto access_check;
 	}
-#endif /* CONFIG_SECURITY_SMACK_NETFILTER */
+
+	skp = smack_ipv4_skb_host_label(skb);
+	if (skp)
+		goto access_check;
 
 	netlbl_secattr_init(&secattr);
 	rc = netlbl_skbuff_getattr(skb, family, &secattr);
@@ -4235,9 +4297,7 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 		skp = &smack_known_huh;
 	netlbl_secattr_destroy(&secattr);
 
-#ifdef CONFIG_SECURITY_SMACK_NETFILTER
 access_check:
-#endif
 
 #ifdef CONFIG_AUDIT
 	smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
@@ -4253,7 +4313,6 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	rc = smk_bu_note("IPv4 connect", skp, ssp->smk_in, MAY_WRITE, rc);
 	if (rc != 0)
 		return rc;
-
 	/*
 	 * Save the peer's label in the request_sock so we can later setup
 	 * smk_packet in the child socket so that SO_PEERCRED can report it.
@@ -4261,22 +4320,11 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	req->peer_secid = skp->smk_secid;
 
 	/*
-	 * We need to decide if we want to label the incoming connection here
-	 * if we do we only need to label the request_sock and the stack will
+	 * Label the incoming connection here.
+	 * Label the request_sock and the stack will
 	 * propagate the wire-label to the sock when it is created.
 	 */
-	hdr = ip_hdr(skb);
-	addr.sin_addr.s_addr = hdr->saddr;
-	rcu_read_lock();
-	hskp = smack_ipv4host_label(&addr);
-	rcu_read_unlock();
-
-	if (hskp == NULL)
-		rc = netlbl_req_setattr(req, &skp->smk_netlabel);
-	else
-		netlbl_req_delattr(req);
-
-	return rc;
+	return netlbl_req_setattr(req, &ssp->smk_out->smk_netlabel);
 }
 
 /**
@@ -4705,7 +4753,7 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(unix_may_send, smack_unix_may_send),
 
 	LSM_HOOK_INIT(socket_post_create, smack_socket_post_create),
-#ifdef SMACK_IPV6_PORT_LABELING
+#ifndef CONFIG_SECURITY_SMACK_NETFILTER
 	LSM_HOOK_INIT(socket_bind, smack_socket_bind),
 #endif
 	LSM_HOOK_INIT(socket_connect, smack_socket_connect),
@@ -4799,13 +4847,9 @@ static __init int smack_init(void)
 
 	pr_info("Smack:  Initializing.\n");
 #ifdef CONFIG_SECURITY_SMACK_NETFILTER
-	pr_info("Smack:  Netfilter enabled.\n");
-#endif
-#ifdef SMACK_IPV6_PORT_LABELING
-	pr_info("Smack:  IPv6 port labeling enabled.\n");
-#endif
-#ifdef SMACK_IPV6_SECMARK_LABELING
 	pr_info("Smack:  IPv6 Netfilter enabled.\n");
+#else
+	pr_info("Smack:  IPv6 port labeling enabled.\n");
 #endif
 
 	/*
diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index e36d17835d4f..5fad28f34698 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -52,7 +52,9 @@ static unsigned int smack_ipv4_output(void *priv,
 	if (sk && sk->sk_security) {
 		ssp = sk->sk_security;
 		skp = ssp->smk_out;
-		skb->secmark = skp->smk_secid;
+		if (ssp->smk_state == SMK_SOCK_DEFERRED &&
+		    netlbl_skbuff_setattr(skb, PF_INET, &skp->smk_netlabel))
+			return NF_DROP;
 	}
 
 	return NF_ACCEPT;
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index f6482e53d55a..fff024258d0e 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -80,7 +80,7 @@ static DEFINE_MUTEX(smk_net6addr_lock);
  * If it isn't somehow marked, use this.
  * It can be reset via smackfs/ambient
  */
-struct smack_known *smack_net_ambient;
+struct smack_known *smack_net_ambient = &smack_known_floor;
 
 /*
  * This is the level in a CIPSO header that indicates a
@@ -718,8 +718,7 @@ static void smk_cipso_doi(void)
 
 	rc = netlbl_cfg_map_del(NULL, PF_INET, NULL, NULL, &nai);
 	if (rc != 0)
-		printk(KERN_WARNING "%s:%d remove rc = %d\n",
-		       __func__, __LINE__, rc);
+		pr_warn("%s remove rc = %d\n", __func__, rc);
 
 	doip = kmalloc(sizeof(struct cipso_v4_doi), GFP_KERNEL);
 	if (doip == NULL)
@@ -733,46 +732,12 @@ static void smk_cipso_doi(void)
 
 	rc = netlbl_cfg_cipsov4_add(doip, &nai);
 	if (rc != 0) {
-		printk(KERN_WARNING "%s:%d cipso add rc = %d\n",
-		       __func__, __LINE__, rc);
-		kfree(doip);
-		return;
-	}
-	rc = netlbl_cfg_cipsov4_map_add(doip->doi, NULL, NULL, NULL, &nai);
-	if (rc != 0) {
-		printk(KERN_WARNING "%s:%d map add rc = %d\n",
-		       __func__, __LINE__, rc);
+		pr_warn("%s cipso add rc = %d\n", __func__, rc);
 		kfree(doip);
 		return;
 	}
 }
 
-/**
- * smk_unlbl_ambient - initialize the unlabeled domain
- * @oldambient: previous domain string
- */
-static void smk_unlbl_ambient(char *oldambient)
-{
-	int rc;
-	struct netlbl_audit nai;
-
-	smk_netlabel_audit_set(&nai);
-
-	if (oldambient != NULL) {
-		rc = netlbl_cfg_map_del(oldambient, PF_INET, NULL, NULL, &nai);
-		if (rc != 0)
-			printk(KERN_WARNING "%s:%d remove rc = %d\n",
-			       __func__, __LINE__, rc);
-	}
-	if (smack_net_ambient == NULL)
-		smack_net_ambient = &smack_known_floor;
-
-	rc = netlbl_cfg_unlbl_map_add(smack_net_ambient->smk_known, PF_INET,
-				      NULL, NULL, &nai);
-	if (rc != 0)
-		printk(KERN_WARNING "%s:%d add rc = %d\n",
-		       __func__, __LINE__, rc);
-}
 
 /*
  * Seq_file read operations for /smack/cipso
@@ -1161,7 +1126,7 @@ static ssize_t smk_write_net4addr(struct file *file, const char __user *buf,
 	struct in_addr mask;
 	unsigned int m;
 	unsigned int masks;
-	int found;
+	bool found = false;
 	u32 mask_bits = (1<<31);
 	__be32 nsa;
 	u32 temp_mask;
@@ -1240,57 +1205,60 @@ static ssize_t smk_write_net4addr(struct file *file, const char __user *buf,
 	mutex_lock(&smk_net4addr_lock);
 
 	nsa = newname.sin_addr.s_addr;
-	/* try to find if the prefix is already in the list */
-	found = 0;
+	/*
+	 * try to find if the prefix is already in the list
+	 */
 	list_for_each_entry_rcu(snp, &smk_net4addr_list, list) {
 		if (snp->smk_host.s_addr == nsa && snp->smk_masks == masks) {
-			found = 1;
+			found = true;
 			break;
 		}
 	}
 	smk_netlabel_audit_set(&audit_info);
 
-	if (found == 0) {
-		snp = kzalloc(sizeof(*snp), GFP_KERNEL);
-		if (snp == NULL)
-			rc = -ENOMEM;
-		else {
-			rc = 0;
-			snp->smk_host.s_addr = newname.sin_addr.s_addr;
-			snp->smk_mask.s_addr = mask.s_addr;
-			snp->smk_label = skp;
-			snp->smk_masks = masks;
-			smk_net4addr_insert(snp);
-		}
+	if (found) {
+		/*
+		 * Delete the existing netlabel mapping.
+		 */
+		rc = netlbl_cfg_map_del(NULL, PF_INET, &snp->smk_host,
+					&snp->smk_mask, &audit_info);
+		if (rc)
+			goto unlock_out;
 	} else {
 		/*
-		 * Delete the unlabeled entry, only if the previous label
-		 * wasn't the special CIPSO option
+		 * Add a new entry.
 		 */
-		if (snp->smk_label != NULL)
-			rc = netlbl_cfg_unlbl_static_del(&init_net, NULL,
-					&snp->smk_host, &snp->smk_mask,
-					PF_INET, &audit_info);
-		else
-			rc = 0;
-		snp->smk_label = skp;
+		snp = kzalloc(sizeof(*snp), GFP_KERNEL);
+		if (snp == NULL) {
+			rc = -ENOMEM;
+			goto unlock_out;
+		}
 	}
 
+	snp->smk_host.s_addr = newname.sin_addr.s_addr;
+	snp->smk_mask.s_addr = mask.s_addr;
+	snp->smk_label = skp;
+	snp->smk_masks = masks;
+
+	if (!found)
+		smk_net4addr_insert(snp);
+
 	/*
-	 * Now tell netlabel about the single label nature of
-	 * this host so that incoming packets get labeled.
-	 * but only if we didn't get the special CIPSO option
+	 * Create the netlabel mapping.
 	 */
-	if (rc == 0 && skp != NULL)
-		rc = netlbl_cfg_unlbl_static_add(&init_net, NULL,
-			&snp->smk_host, &snp->smk_mask, PF_INET,
-			snp->smk_label->smk_secid, &audit_info);
+	if (skp)
+		rc = netlbl_cfg_unlbl_map_add(NULL, PF_INET, &snp->smk_host,
+						&snp->smk_mask, &audit_info);
+	else
+		rc = netlbl_cfg_cipsov4_map_add(smk_cipso_doi_value, NULL,
+						&snp->smk_host, &snp->smk_mask,
+						&audit_info);
 
 	if (rc == 0)
 		rc = count;
 
+unlock_out:
 	mutex_unlock(&smk_net4addr_lock);
-
 free_out:
 	kfree(smack);
 free_data_out:
@@ -1837,7 +1805,6 @@ static ssize_t smk_write_ambient(struct file *file, const char __user *buf,
 				 size_t count, loff_t *ppos)
 {
 	struct smack_known *skp;
-	char *oldambient;
 	char *data;
 	int rc = count;
 
@@ -1855,11 +1822,7 @@ static ssize_t smk_write_ambient(struct file *file, const char __user *buf,
 	}
 
 	mutex_lock(&smack_ambient_lock);
-
-	oldambient = smack_net_ambient->smk_known;
 	smack_net_ambient = skp;
-	smk_unlbl_ambient(oldambient);
-
 	mutex_unlock(&smack_ambient_lock);
 
 out:
@@ -2947,11 +2910,113 @@ static struct file_system_type smk_fs_type = {
 
 static struct vfsmount *smackfs_mount;
 
+/**
+ * smk_new_net4addr - allocate and insert a new netlabel entry.
+ *
+ */
+static void __init smk_new_net4addr(struct in_addr *addr, struct in_addr *mask,
+				    struct smack_known *label, u32 masks)
+{
+	struct smk_net4addr *snp;
+
+	snp = kzalloc(sizeof(*snp), GFP_KERNEL);
+	if (snp == NULL)
+		return;
+
+	snp->smk_host.s_addr = addr->s_addr;
+	snp->smk_mask.s_addr = mask->s_addr;
+	snp->smk_label = label;
+	snp->smk_masks = masks;
+	mutex_lock(&smk_net4addr_lock);
+	smk_net4addr_insert(snp);
+	mutex_unlock(&smk_net4addr_lock);
+}
+
+/**
+ * smk_netlbl_local - initialize the CIPSO local domain
+ */
+static void __init smk_netlbl_local(void)
+{
+	int rc;
+	struct cipso_v4_doi *doip;
+	struct netlbl_audit nai;
+	struct in_addr addr;
+	struct in_addr mask;
+
+	smk_netlabel_audit_set(&nai);
+
+	doip = kmalloc(sizeof(struct cipso_v4_doi), GFP_KERNEL);
+	if (doip == NULL)
+		panic("smack:  Failed to initialize cipso local DOI.\n");
+
+	/*
+	 * Create a CIPSO domain for LOCAL mapping.
+	 * This is used on the loopback address.
+	 */
+	doip->map.std = NULL;
+	doip->doi = 2;
+	doip->type = CIPSO_V4_MAP_LOCAL;
+	doip->tags[0] = CIPSO_V4_TAG_LOCAL;
+	for (rc = 1; rc < CIPSO_V4_TAG_MAXCNT; rc++)
+		doip->tags[rc] = CIPSO_V4_TAG_INVALID;
+
+	rc = netlbl_cfg_cipsov4_add(doip, &nai);
+	if (rc != 0) {
+		pr_warn("%s cipso local add rc = %d\n", __func__, rc);
+		kfree(doip);
+		return;
+	}
+
+	/*
+	 * Create the CIPSO DOI=2 (LOCAL) mapping for the loopback
+	 */
+	addr.s_addr = cpu_to_be32(0x7f000001);
+	mask.s_addr = cpu_to_be32(0xffffffff);
+	rc = netlbl_cfg_cipsov4_map_add(2, NULL, &addr, &mask, &nai);
+	if (rc != 0) {
+		pr_warn("%s map local add rc = %d\n", __func__, rc);
+		kfree(doip);
+		return;
+	}
+	smk_new_net4addr(&addr, &mask, NULL, 32);
+
+	/*
+	 * Set up how to talk to the rest of the world.
+	 */
+	addr.s_addr = cpu_to_be32(0x00000000);
+	mask.s_addr = cpu_to_be32(0x00000000);
+	smk_netlabel_audit_set(&nai);
+
+#ifdef CONFIG_SECURITY_SMACK_ALLCIPSO
+	/*
+	 * Create the CIPSO DOI=3 (PASS_THROUGH) mapping
+	 */
+	rc = netlbl_cfg_cipsov4_map_add(smk_cipso_doi_value, NULL, &addr,
+					&mask, &nai);
+#else
+	/*
+	 * Create the unlabeled mapping for all hosts that
+	 * are not explicitly set (at this point, the loopback)
+	 */
+	rc = netlbl_cfg_unlbl_map_add(NULL, PF_INET, &addr, &mask, &nai);
+#endif
+	if (rc != 0) {
+		pr_warn("%s map add rc = %d\n", __func__, rc);
+		kfree(doip);
+		return;
+	}
+	smk_new_net4addr(&addr, &mask,
+		IS_ENABLED(CONFIG_SECURITY_SMACK_ALLCIPSO) ?
+			NULL : smack_net_ambient, 0);
+}
+
 static int __init smk_preset_netlabel(struct smack_known *skp)
 {
+	skp->smk_netlabel.attr.secid = skp->smk_secid;
 	skp->smk_netlabel.domain = skp->smk_known;
-	skp->smk_netlabel.flags =
-		NETLBL_SECATTR_DOMAIN | NETLBL_SECATTR_MLS_LVL;
+	skp->smk_netlabel.flags = NETLBL_SECATTR_DOMAIN |
+				  NETLBL_SECATTR_MLS_LVL |
+				  NETLBL_SECATTR_SECID;
 	return smk_netlbl_mls(smack_cipso_direct, skp->smk_known,
 				&skp->smk_netlabel, strlen(skp->smk_known));
 }
@@ -2992,7 +3057,7 @@ static int __init init_smk_fs(void)
 	}
 
 	smk_cipso_doi();
-	smk_unlbl_ambient(NULL);
+	smk_netlbl_local();
 
 	rc = smk_preset_netlabel(&smack_known_floor);
 	if (err == 0 && rc < 0)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
