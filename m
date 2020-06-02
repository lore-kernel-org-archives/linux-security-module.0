Return-Path: <SRS0=3Oq2=7P=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F92C433E0
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Jun 2020 21:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C1282065C
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Jun 2020 21:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgFBVP0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Jun 2020 17:15:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52348 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFBVPZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Jun 2020 17:15:25 -0400
Received: from mail-qv1-f70.google.com ([209.85.219.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1jgEFm-0003mV-34
        for linux-security-module@vger.kernel.org; Tue, 02 Jun 2020 21:15:22 +0000
Received: by mail-qv1-f70.google.com with SMTP id ba13so2273197qvb.15
        for <linux-security-module@vger.kernel.org>; Tue, 02 Jun 2020 14:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yrqIDJ5oe8/rxqhrRnyAnLugkJ19tIqkIPGOMWQKLL8=;
        b=R0VoNZOdwe26Z1fQ1i3sRBXSWuQuajJMKsJeGvzf2DfD5TY8vwRobtNfZ2vUbbCYxo
         PdYkgpdpVB+8Dop9utVdBHBtE1qSOGbaz+t3F8jOJGNsv6u4V/ymIjVzH7+dIOMKuTNU
         PC4K3v26cOzbcGQiTXw9lAt8tj33hbBkqQ927uwkg8Yv4yu3uhWgyjDx1TD0qjmblW8I
         69jNyH9FP58MiyDeP7X6UIQTpjSk6vkTJuDMK/+e0DAwdJkHqFwoNL9YwhAM2JpkxdgE
         6oELncarHCST+Gc+52Kd8TflqJOmNpz6o1xvzEjE3Ru+UbqucYd8gFqj6ERlSibKYP35
         hwoA==
X-Gm-Message-State: AOAM530Li2wms8ODlwPuAR3xvtWFWdKz/RcIU6bqve75sUx6uLqU25TR
        G3k/kFF8niZ536uuN4AOjcJA40Mhllfc/puC7XZkTo8Fm+0dJfKx//sj8EDW7DcHfX0KKLCah2y
        5w5pT8ZllorTBCcW6pb0oYorn8R/dolyoFGmPNfWmGEnC4i6uRQVHrQ==
X-Received: by 2002:a05:6214:4af:: with SMTP id w15mr2305755qvz.11.1591132520818;
        Tue, 02 Jun 2020 14:15:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy//ATvXzqJKobmg29ShwU+CgsPSFb8lihT+kB1AwGSCPt3o3CUtsutdK8Eeo1YVIY+3kSsFw==
X-Received: by 2002:a05:6214:4af:: with SMTP id w15mr2305735qvz.11.1591132520516;
        Tue, 02 Jun 2020 14:15:20 -0700 (PDT)
Received: from localhost.localdomain ([179.159.56.229])
        by smtp.gmail.com with ESMTPSA id t13sm79918qtc.77.2020.06.02.14.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 14:15:20 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     John Johansen <john.johansen@canonical.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH] apparmor: check/put label on apparmor_sk_clone_security()
Date:   Tue,  2 Jun 2020 18:15:16 -0300
Message-Id: <20200602211516.446847-1-mfo@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Currently apparmor_sk_clone_security() does not check for existing
label/peer in the 'new' struct sock; it just overwrites it, if any
(with another reference to the label of the source sock.)

    static void apparmor_sk_clone_security(const struct sock *sk,
                                           struct sock *newsk)
    {
            struct aa_sk_ctx *ctx = SK_CTX(sk);
            struct aa_sk_ctx *new = SK_CTX(newsk);

            new->label = aa_get_label(ctx->label);
            new->peer = aa_get_label(ctx->peer);
    }

This might leak label references, which might overflow under load.
Thus, check for and put labels, to prevent such errors.

Note this is similarly done on:

    static int apparmor_socket_post_create(struct socket *sock, ...)
    ...
            if (sock->sk) {
                    struct aa_sk_ctx *ctx = SK_CTX(sock->sk);

                    aa_put_label(ctx->label);
                    ctx->label = aa_get_label(label);
            }
    ...

Context:
-------

The label reference count leak is observed if apparmor_sock_graft()
is called previously: this sets the 'ctx->label' field by getting
a reference to the current label (later overwritten, without put.)

    static void apparmor_sock_graft(struct sock *sk, ...)
    {
            struct aa_sk_ctx *ctx = SK_CTX(sk);

            if (!ctx->label)
                    ctx->label = aa_get_current_label();
    }

And that is the case on crypto/af_alg.c:af_alg_accept():

    int af_alg_accept(struct sock *sk, struct socket *newsock, ...)
    ...
            struct sock *sk2;
            ...
            sk2 = sk_alloc(...);
            ...
            security_sock_graft(sk2, newsock);
            security_sk_clone(sk, sk2);
    ...

Apparently both calls are done on their own right, especially for
other LSMs, being introduced in 2010/2014, before apparmor socket
mediation in 2017 (see commits [1,2,3,4]).

So, it looks OK there! Let's fix the reference leak in apparmor.

Test-case:
---------

Exercise that code path enough to overflow label reference count.

    $ cat aa-refcnt-af_alg.c
    #include <stdio.h>
    #include <string.h>
    #include <unistd.h>
    #include <sys/socket.h>
    #include <linux/if_alg.h>

    int main() {
            int sockfd;
            struct sockaddr_alg sa;

            /* Setup the crypto API socket */
            sockfd = socket(AF_ALG, SOCK_SEQPACKET, 0);
            if (sockfd < 0) {
                    perror("socket");
                    return 1;
            }

            memset(&sa, 0, sizeof(sa));
            sa.salg_family = AF_ALG;
            strcpy((char *) sa.salg_type, "rng");
            strcpy((char *) sa.salg_name, "stdrng");

            if (bind(sockfd, (struct sockaddr *) &sa, sizeof(sa)) < 0) {
                    perror("bind");
                    return 1;
            }

            /* Accept a "connection" and close it; repeat. */
            while (!close(accept(sockfd, NULL, 0)));

            return 0;
    }

    $ gcc -o aa-refcnt-af_alg aa-refcnt-af_alg.c

    $ ./aa-refcnt-af_alg
    <a few hours later>

    [ 9928.475953] refcount_t overflow at apparmor_sk_clone_security+0x37/0x70 in aa-refcnt-af_alg[1322], uid/euid: 1000/1000
    ...
    [ 9928.507443] RIP: 0010:apparmor_sk_clone_security+0x37/0x70
    ...
    [ 9928.514286]  security_sk_clone+0x33/0x50
    [ 9928.514807]  af_alg_accept+0x81/0x1c0 [af_alg]
    [ 9928.516091]  alg_accept+0x15/0x20 [af_alg]
    [ 9928.516682]  SYSC_accept4+0xff/0x210
    [ 9928.519609]  SyS_accept+0x10/0x20
    [ 9928.520190]  do_syscall_64+0x73/0x130
    [ 9928.520808]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Note that other messages may be seen, not just overflow, depending on
the value being incremented by kref_get(); on another run:

    [ 7273.182666] refcount_t: saturated; leaking memory.
    ...
    [ 7273.185789] refcount_t: underflow; use-after-free.

Kprobes:
-------

Using kprobe events to monitor sk -> sk_security -> label -> count (kref):

Original v5.7 (one reference leak every iteration)

 ... (af_alg_accept+0x0/0x1c0) label=0xffff8a0f36c25eb0 label_refcnt=0x11fd2
 ... (af_alg_release_parent+0x0/0xd0) label=0xffff8a0f36c25eb0 label_refcnt=0x11fd4
 ... (af_alg_accept+0x0/0x1c0) label=0xffff8a0f36c25eb0 label_refcnt=0x11fd3
 ... (af_alg_release_parent+0x0/0xd0) label=0xffff8a0f36c25eb0 label_refcnt=0x11fd5
 ... (af_alg_accept+0x0/0x1c0) label=0xffff8a0f36c25eb0 label_refcnt=0x11fd4
 ... (af_alg_release_parent+0x0/0xd0) label=0xffff8a0f36c25eb0 label_refcnt=0x11fd6

Patched v5.7 (zero reference leak per iteration)

 ... (af_alg_accept+0x0/0x1c0) label=0xffff9ff376c25eb0 label_refcnt=0x593
 ... (af_alg_release_parent+0x0/0xd0) label=0xffff9ff376c25eb0 label_refcnt=0x594
 ... (af_alg_accept+0x0/0x1c0) label=0xffff9ff376c25eb0 label_refcnt=0x593
 ... (af_alg_release_parent+0x0/0xd0) label=0xffff9ff376c25eb0 label_refcnt=0x594
 ... (af_alg_accept+0x0/0x1c0) label=0xffff9ff376c25eb0 label_refcnt=0x593
 ... (af_alg_release_parent+0x0/0xd0) label=0xffff9ff376c25eb0 label_refcnt=0x594

Commits:
-------

[1] commit 507cad355fc9 ("crypto: af_alg - Make sure sk_security is initialized on accept()ed sockets")
[2] commit 4c63f83c2c2e ("crypto: af_alg - properly label AF_ALG socket")
[3] commit 2acce6aa9f65 ("Networking") a.k.a ("crypto: af_alg - Avoid sock_graft call warning)
[4] commit 56974a6fcfef ("apparmor: add base infastructure for socket mediation")

Reported-by: Brian Moyles <bmoyles@netflix.com>
Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 security/apparmor/lsm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index b621ad74f54a..66a8504c8bea 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -804,7 +804,12 @@ static void apparmor_sk_clone_security(const struct sock *sk,
 	struct aa_sk_ctx *ctx = SK_CTX(sk);
 	struct aa_sk_ctx *new = SK_CTX(newsk);
 
+	if (new->label)
+		aa_put_label(new->label);
 	new->label = aa_get_label(ctx->label);
+
+	if (new->peer)
+		aa_put_label(new->peer);
 	new->peer = aa_get_label(ctx->peer);
 }
 
-- 
2.25.1

