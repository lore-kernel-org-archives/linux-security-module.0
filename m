Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719959;
	b=lks8FXk6/vxRm8Z4qqhbl+bpjh07sPfeoLoPEQoOFVILdadMTyT8bTkeg0v/1+33Yt0U
	 nBmv6amzoxMEVOVTAXKhOUcSiKsLMRTS/JG8cTYsnEDO8NRBFynGNaCgunM2xbNQQb1w1
	 ByW6uc93QrefnLaLZ1gA+4o28y+7UZQhoqhxX2ia1tazMBxp6CRX6FOlneLgFDxY0zb0o
	 4CYLv+B3d3ZQDncHzS8Ek9nfFF92WTqkw4bvV6WaWD8tcMzvmySjVaOg+/5V92Vffx87Z
	 aH9C3UgiLjia0DjTTw7HZbOoLPq7MTi+jvXD87OJ+xreQCo3GqOgJyxbfqgf3Fy2wsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719959;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Organization:From:In-Reply-To:
	 References:To:Cc:Subject:MIME-Version:Date:Message-ID:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:Content-ID;
	bh=VmOZ73jgvHkU0dumvVNmxvri2WLmB7Wyi+ggYVy61Tw=;
	b=aGTvOZ6P+iJDlhQcQpfHPPALsb6zu7iPszHS6Dd6zm+busnCkdTAn7PKJtpQRuNjtVWn
	 WdDW1EeBTgpkmzqLIF6neCkgMWCrkaEDS2dZO6+6igVe26fbhGtack5TBCJWVbvm/Pg0l
	 sanKVOkZgVpCch60gb8HdYy5dyJAqj5+aj0pG/SXGNO9b8pEpaL2Aqd7gXZJiKu3DOybX
	 1vNprJjqrfXu7+5KwOj2Om2yP8CamjYzWcMbSlzCMlHDSIAFf/+Zd+BLszib5szynW2/e
	 HV4pvEkVIGHvdKv/Pf/PYV1Q0Qh0R3Mr/ft9PrdVBzjT+0d5I1OSF6JYYK7vjQVV/1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="jOmaPxj/";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195C9606D823
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 15:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 195C9606D823
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jOmaPxj/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793719958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VmOZ73jgvHkU0dumvVNmxvri2WLmB7Wyi+ggYVy61Tw=;
	b=jOmaPxj/di54IFq5WJTTVD9rb2L0oxXEmFnpe9V+WI9aecZXumQ9n04Zg1w0mOp1hY/8f0
	9Le9VP6gFTS3SZHjGR3OpcWbgMWSLd4CmHgBAUOhc64lJB62V6pjfPHAwx3RIy9d+yU1+O
	0WZk0KHbau3n6WsI/zQAPDlFKGxAssg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-iXgHiXyjMFO01IbGrQNv8Q-1; Tue,
 03 Nov 2026 10:32:33 -0500
X-MC-Unique: iXgHiXyjMFO01IbGrQNv8Q-1
X-Mimecast-MFC-AGG-ID: iXgHiXyjMFO01IbGrQNv8Q_1793719951
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A9671956057;
	Tue,  3 Nov 2026 15:32:31 +0000 (UTC)
Received: from dhowells-thinkpadp1gen8.rmtgb.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 67B3118005B0;
	Tue,  3 Nov 2026 15:32:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aun4kXCJDtYomzpu@kernel.org>
References: <aun4kXCJDtYomzpu@kernel.org> <aunNj35KmcAC4ByH@kernel.org> <20261103030226.2685251-1-jarkko@kernel.org> <641294.1793700187@dhowells-thinkpadp1gen8.rmtgb.csb> <669211.1793714419@dhowells-thinkpadp1gen8.rmtgb.csb>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, Eric Biggers <ebiggers@kernel.org>,
    linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
    keyrings@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
    Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
    Eric Snowberg <eric.snowberg@oracle.com>,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>,
    "open
 list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
    open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 00/11] KEYS: Sanitize the garbage collector
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 03 Nov 2026 15:32:26 +0000
Message-ID: <683284.1793719946@dhowells-thinkpadp1gen8.rmtgb.csb>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: dBd86WUBd_lr8b_Oq5IjFIrZxfjUX5-ID_P2crXQ6bU_1793719951
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <683283.1793719946.1@dhowells-thinkpadp1gen8.rmtgb.csb>

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> > Actually, it can be done if the rxrpc and rxrpc_s key types are moved out
> > into their own module upon which rxrpc.ko depends.
> 
> Hmm... I'll experiment with this, thanks. This was useful.

It's not entirely trivial.  I've attached a patch that makes a start on it,
but it needs access to bits of the security class implementations (rxkad and
rxgk).  Those bits only parse the key (and in the case of rxgk access the krb5
code), so in theory it should be possible to extract them out.

One thing that needs to be considered, though, is the security class selected
should really be up to the application, not merely switched on by the
security_id.  This is one of the reasons I would like to add an add_key2()
syscall that adds an additional parameter string argument.

David
---
commit 365e715b91b9b2ac3030f51c31ff4de8f24a4e19
Author: David Howells <dhowells@redhat.com>
Date:   Tue Nov 3 14:15:39 2026 +0000

    rxrpc: Move key types to own module
    
    Move the rxrpc and rxrpc_s key types to their own module so that if keys
    pin the module that implements the type, they don't cause outstanding
    connections to make the module unremovable.
    
    Signed-off-by: David Howells <dhowells@redhat.com>

diff --git a/net/Makefile b/net/Makefile
index 5b2dd7f07a85..f543097c89b9 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -30,7 +30,7 @@ obj-$(CONFIG_LAPB)		+= lapb/
 obj-$(CONFIG_CAN)		+= can/
 obj-$(CONFIG_BT)		+= bluetooth/
 obj-$(CONFIG_SUNRPC)		+= sunrpc/
-obj-$(CONFIG_AF_RXRPC)		+= rxrpc/
+obj-$(CONFIG_RXRPC_KEYS)	+= rxrpc/
 obj-$(CONFIG_AF_KCM)		+= kcm/
 obj-$(CONFIG_STREAM_PARSER)	+= strparser/
 obj-$(CONFIG_ATM)		+= atm/
diff --git a/net/rxrpc/Kconfig b/net/rxrpc/Kconfig
index 2cebb666dc07..ffd42d71f85a 100644
--- a/net/rxrpc/Kconfig
+++ b/net/rxrpc/Kconfig
@@ -3,6 +3,14 @@
 # RxRPC session sockets
 #
 
+config RXRPC_KEYS
+	tristate "RxRPC key types"
+	select CRYPTO
+	select CRYPTO_LIB_DES if RXKAD
+	select KEYS
+	help
+	  Say Y or M here to include support for rxrpc and rxrpc_s key types.
+
 config AF_RXRPC
 	tristate "RxRPC session sockets"
 	depends on INET
@@ -10,6 +18,7 @@ config AF_RXRPC
 	select CRYPTO_LIB_DES if RXKAD
 	select KEYS
 	select NET_UDP_TUNNEL
+	select RXRPC_KEYS
 	help
 	  Say Y or M here to include support for RxRPC session sockets (just
 	  the transport part, not the presentation part: (un)marshalling is
diff --git a/net/rxrpc/Makefile b/net/rxrpc/Makefile
index f994f9f30a29..196e0ce085ba 100644
--- a/net/rxrpc/Makefile
+++ b/net/rxrpc/Makefile
@@ -3,6 +3,7 @@
 # Makefile for Linux kernel RxRPC
 #
 
+obj-$(CONFIG_RXRPC_KEYS) += rxrpc_keys.o
 obj-$(CONFIG_AF_RXRPC) += rxrpc.o
 
 rxrpc-y := \
@@ -19,7 +20,6 @@ rxrpc-y := \
 	input_rack.o \
 	insecure.o \
 	io_thread.o \
-	key.o \
 	local_event.o \
 	local_object.o \
 	misc.o \
@@ -32,7 +32,6 @@ rxrpc-y := \
 	rtt.o \
 	security.o \
 	sendmsg.o \
-	server_key.o \
 	skbuff.o \
 	txbuf.o \
 	utils.o
@@ -45,5 +44,9 @@ rxrpc-$(CONFIG_RXGK) += \
 	rxgk_app.o \
 	rxgk_kdf.o
 
+rxrpc_keys-y := \
+	key.o \
+	server_key.o
+
 obj-$(CONFIG_RXPERF) += rxperf.o
 obj-$(CONFIG_KUNIT) += tests/
diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index cbd26da44951..c353a4304788 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -893,3 +893,39 @@ static long rxrpc_read(const struct key *key,
 	_leave(" = %zu", size);
 	return size;
 }
+
+/*
+ * initialise and register the RxRPC protocol
+ */
+static int __init rxrpc_keys_init(void)
+{
+	int ret;
+
+	ret = register_key_type(&key_type_rxrpc);
+	if (ret < 0) {
+		pr_crit("Cannot register client key type\n");
+		goto error_key_type;
+	}
+
+	ret = register_key_type(&key_type_rxrpc_s);
+	if (ret < 0) {
+		pr_crit("Cannot register server key type\n");
+		goto error_key_type_s;
+	}
+
+	return 0;
+
+error_key_type_s:
+	unregister_key_type(&key_type_rxrpc);
+error_key_type:
+	return ret;
+}
+
+static void __exit rxrpc_keys_exit(void)
+{
+	unregister_key_type(&key_type_rxrpc_s);
+	unregister_key_type(&key_type_rxrpc);
+}
+
+module_init(rxrpc_keys_init);
+module_exit(rxrpc_keys_exit);
diff --git a/net/rxrpc/server_key.c b/net/rxrpc/server_key.c
index 3efe104b1930..b5e60a3364ad 100644
--- a/net/rxrpc/server_key.c
+++ b/net/rxrpc/server_key.c
@@ -42,6 +42,7 @@ struct key_type key_type_rxrpc_s = {
 	.destroy	= rxrpc_destroy_s,
 	.describe	= rxrpc_describe_s,
 };
+EXPORT_SYMBOL(key_type_rxrpc_s);
 
 /*
  * Vet the description for an RxRPC server key.

