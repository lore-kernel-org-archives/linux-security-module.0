Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793625221;
	b=ZyeYlXH5PgLnoUu6VlBZ0K/pXtgaTMZ27DZobntE82YGFejZZGLqggyVjKuSvekhIf88
	 sZzUfVdigge1TAG1rasAcIzY6SVjN0F9MAM+MrgCzPa1n5BYHvxysoyTiXjDBe+F1gHsX
	 XiB8D/xw/gC56sPklSPND76qus6w9fwtMfJ8fJkTZmyWnfL9oyFMKlFlmlJVEw9EIlEYj
	 0iL82UxGnr79WLcomk5BsUzO2UBoz/8bpZdFvuRSfc5gkdxE/lyAOlPll68BxxOaRs6G9
	 4JFiwaipMf9vf5A0D7JV5jKTa4b1T2AfWz+jiW2fJWHOPwZ+5DqUgFfgIqxTJbPbEmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rC8xVMt0ftVC1MA0/AxMx0dm+YERO32RQqLOxWhbSdM=;
	b=09T4Ffi0oQcqzYGg+aMK4El61Gi2C+9mmkfCeXfn0fUCtHoz1JrbhP6u0lI5U/ESMWyf
	 RH+0ucFKOq9dUpKGApT2v/NqILVxWPUpIv/zMXG+W2b1GTtktGu2FvHX/nsm71YRmY+jw
	 KIBCH2QTmW76fG7RFIES23tERMUP9dR0OMV8wxaMY8IaqEiuCPW8HeAXmaqXLRxE/NhJi
	 B3hCL3BhhVXRM6BXHwUMj/UXC08xO0QTw2kWvLbAhKmw6BBzCTPERA8bftKTb5O4ss4eI
	 Hun0O1JbgrpLEULVTxnGZ8o/DLI9pRPvq5CQSDn8ZQiUmN/Myd50ckY6EJ/QjxgFnyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o9Bv0lrt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43162606A329
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 13:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43162606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o9Bv0lrt
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-19305bcb72cso2049035c88.1
        for <linux-security-module@vger.kernel.org>; Mon, 02 Nov 2026 05:13:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793625220; cv=none;
        d=google.com; s=arc-20260327;
        b=LJO4mWsMu30NltKhflimI+TNi7x7jIsDbEnDd1YJ/RCqY5VME1vIGOTfCF1A7/4pU9
         H3lza7nSVBV1NdSvJI7IBkmWiM4YmqGtxOz+THzU4cgAzPGg9h7rzC7JarXGeD3duR/x
         Nz2i6MAclzMMAkiHQ5wQ7dTtm5iKwNUO5x3+V4sRV5lXTSDYM2/nzoJsQb9cjc7Suxk0
         h3/kLTm/cF17DdlGJXNJ95kKu1EiPfZ9J5jzZWEYsb745X1glladroX83wsYOPgHXEWU
         YRKUfxGIoSI//1NdSRnLe8FWuU4DUxcSlChsee9lTqkbzAxQ3olStK5QV7qQDm9qzERN
         pU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rC8xVMt0ftVC1MA0/AxMx0dm+YERO32RQqLOxWhbSdM=;
        fh=rtnLOVc3qERLC4xNICpeMuwUWefM+I7g2BEEzabqb60=;
        b=qoo7Xt4RV6YBjXbuRzFo8NvorwQcxJRpmF7p9kk5/y/PpsBLjO5RhoeFi0tV9JgqFb
         +nRFBnVlM5yYUdzQQpzfp/P6Fm6gE5jOvQGnVHgQ4C1+sv6DNSGWMsH1fC8zUMNZSOGr
         byoAila+u5IMsS3Q7qU84ueypKpyhekUJ/YwLvJxb0UBM67nlZXjZIwWvTY/qaHmjVvt
         E8X+r57EAmf1dj6cQQXF0YTd7FnzHLIvb2na/rKKskcG1o5JiO/03lQb4HBeyImMvZ1b
         Xx5CPcXAFEEwhoAzEe4tRRpB40pfQjsYxJ4jOiKqRKGpYKHwlisy5+qyd46QypJfdeCj
         eTvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793625220; x=1794230020; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rC8xVMt0ftVC1MA0/AxMx0dm+YERO32RQqLOxWhbSdM=;
        b=o9Bv0lrtHh2cwTJJVMUH4k06fPh+ZUF1Xl51YCyt5LSal/HMFyjV6eP5ndcJg+7iVj
         WTAY3phbzSA8x/6rfLnLvb4bDnZ8Y4PG1EA0o2RPOfRyLwq6jcyjm/QiNRIf9j5AQQsJ
         l2LCkDlG//3sWy/odK1wwz5yKvgETNvSW47fduZrW/zlPZQm2Hr6OF9occ90dnwda9pH
         15peHnhylM0gwl1DeCkmpBva8CbqeJR2lmvPc9gUGtCRkIGAVwQC32c4UK+T3jOODMWv
         8UTKrgc631symoPetFblG9qRPrnzh0NbDQA57q01cYj3VhCGGF8OfpP+shjngzwAm22m
         UCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793625220; x=1794230020;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rC8xVMt0ftVC1MA0/AxMx0dm+YERO32RQqLOxWhbSdM=;
        b=bj/XAIe39r55Z+9K++vAJByZyVNYFqdVuhQ0BiSp2xSh0AslGpOhTrXfLCbMl5XUtP
         OW8iGTLC4ap21PJiJxIgHXi2NpRqAEZFOfUUFac59JBkpWHYG8sz5p166MbrXbAQwAH4
         loqyt+cvF2AXUcLQqN8EF7qN/IKZ934b1w9UVItNyKBiC1J61qj4f54mt6FYSuYndyh4
         PtOXBhcZ1oxN8Xr09e0UeeQwIqZzsgr5a6B/068snmjSKXKIKnu0lBxL35XWUePlXb0C
         GxMJrcvyJqPAl99RTkReat85+GcmAvDe2m2po/gHaqQVNWfgYYApD/OnHP1P9cKqiOSc
         +cRg==
X-Forwarded-Encrypted: i=1; AKwUvBwJTL3YId6kTtsWiB48sg70zDwAWWrBBsqJI6ysLFReiSdcssXO7N03m/Jx+2TP+yQQfnQVNLfxmyew5+uZm2uqSTyauXA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKefTApFp2C0Fmev5NjL/DMP6U0gYKAk45PypbKAij0FxWg4jKe
	cvZxryPFN6hMAZKtac53mqzh7K1VuWjHct8K5pQLlKyLM0q5ou+lD0jdkFh/3lsx0tlN4A/eU1F
	TGBAsWs6A/pd+CX+TQ+bVsPMcqhf8kfw=
X-Gm-Gg: AYBFou0yi5v0n9kIo82vosdqmQ5wlv4TDCjkzD6uNZ1QAuZHlONqOOtboFvDQZVeERF
	0iKviDGH/BtmA/xUX69LJ0i4g8giaWQPoiiOhkNBp7wjyZpkmHTe6+HRPQY7a9rZVOYPu9U4FbS
	vcYjeVUaqzs0GB7VwSPSs7bhP7hJQ21pECYEmrGd4vgKMUYrhdVpV3cZIg1B0ljPi8/nQm+DhIe
	5CO0fbAehpACAW5Q0tUrdXDge5L55Lc2p9uoyB070WimOnaYYtY/nVbyCRJxdZ01T+lAkUIE77L
	XRZ+NuYTngaW7Z2ohqy+sEJ1sc5dsaTIwlZIYhhKJbEQxOPc2U9aYc+792fULTxOlttc9XeC6Wb
	1uEev+EetoxHywU1HoQZ/dBdddIOYKyBMAfikjCtY8zzMAM4URKPpdlBbhoz4fX4dRVyW
X-Received: by 2002:a05:701b:230e:b0:14a:8cff:fbb8 with SMTP id
 a92af1059eb24-1ac5bbb5053mr14722111c88.28.1793625220279; Mon, 02 Nov 2026
 05:13:40 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102130540.252894-1-omosnacek@gmail.com>
In-Reply-To: <20261102130540.252894-1-omosnacek@gmail.com>
From: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date: Mon, 2 Nov 2026 14:13:28 +0100
X-Gm-Features: AclHuK9Lk_3jmZnqSr1tjOillycrUr-WcgCLTZN6r2TRwhWtp1BoaHKbHJvYD28
Message-ID: <CAAUqJDvsDi5ceO3ri5cJP4WJbZeUdpJe9F4cv8OU4=wBzVeBAw@mail.gmail.com>
Subject: Re: [RFC PATCH] af_unix: introduce MSG_CMSG_SEALED
To: Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, netdev@vger.kernel.org, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Nov 2026 at 14:05, Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com=
> wrote:
>
> Currently, when a process receives a file through AF_UNIX's SCM_RIGHTS
> mechanism, the security_file_receive() LSM hook is calledto allow LSMs
> like SELinux to validate the receiver's access to the received file
> (similarly to a process inheriting file descriptors through execve(2)).
>
> However, there are cases (such as dbus daemon/dbus-broker) where the
> receiver doesn't intend to access the received file and merely wants to
> forward it to a third process. In this case the forwarding process would
> need to have the appropriate r/w access to the file in order to receive
> it, even though it will never actually acess it. That leads to the
> security policy having to grant the forwarder access to a potentially
> wide range of files (in case of dbus-broker basically all files), which
> is not ideal.
>
> This patch adds a new CMSG flag MSG_CMSG_SEALED that, when passed to
> recvmsg(2), wraps any received files into an opaque anonymous inode with
> the name "[envelope]", skipping the security_file_receive() LSM check.
> The returned "[envelope]" file descriptor can't be used in any
> meaningful way other than being passed forward via sendmsg(2) with the
> MSG_CMSG_SEALED flag. In that case the original file is unwrapped and
> sent via SCM_RIGHTS to the receiver. The receiver can then either
> receive the file as normal (subject to the LSM check) or again "sealed"
> in the "[envelope]" anon inode for further forwarding.
>
> Note that sending the "[envelope]" file is only allowed with the
> MSG_CMSG_SEALED flag set, to make the unsealing explicit and avoid
> unexpected behavior. Attempting to send it without this flag will fail
> with an error. This also avoids recursive nesting of "[envelope]" files,
> which would only make this feature harder to audit for possible issues.
>
> This patch also adds a simple read-only sockopt for UNIX sockets that
> allows userspace to determine if this feature is present (passing
> unknown CMSG flags unfortunately doesn't lead to an error currently).
> The minimal code to do so can look like this:
>
>     #ifndef SO_RIGHTS_SEALED_SUPPORTED
>     #define SO_RIGHTS_SEALED_SUPPORTED 88
>     #endif
>
>     #include <sys/socket.h>
>     #include <unistd.h>
>     #include <stdbool.h>
>
>     bool MSG_CMSG_SEALED_supported(void)
>     {
>         int sock, ret;
>         socklen_t optlen =3D 0;
>
>         sock =3D socket(AF_UNIX, SOCK_STREAM, 0);
>         if (sock < 0) {
>             /* handle error */
>             /* ... */
>         }
>
>         ret =3D getsockopt(sock, SOL_SOCKET, SO_RIGHTS_SEALED_SUPPORTED,
>                          NULL, &optlen);
>         close(sock);
>
>         return ret =3D=3D 0;
>     }
>
> Related: https://github.com/fedora-selinux/selinux-policy/issues/3286
> Related: https://github.com/fedora-selinux/selinux-policy/issues/3287
> Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> ---
>  arch/alpha/include/uapi/asm/socket.h    |  2 +
>  arch/mips/include/uapi/asm/socket.h     |  2 +
>  arch/parisc/include/uapi/asm/socket.h   |  2 +
>  arch/sparc/include/uapi/asm/socket.h    |  2 +
>  include/linux/socket.h                  |  4 +-
>  include/net/scm.h                       |  2 +-
>  include/uapi/asm-generic/socket.h       |  2 +
>  io_uring/net.c                          |  2 +-
>  net/compat.c                            |  3 +-
>  net/core/scm.c                          | 81 +++++++++++++++++++++----
>  net/core/sock.c                         |  9 +++
>  net/socket.c                            |  2 +-
>  tools/include/uapi/asm-generic/socket.h |  2 +
>  13 files changed, 97 insertions(+), 18 deletions(-)

See also this RFC patch for selinux-testsuite
(https://github.com/SELinuxProject/selinux-testsuite) that I used to
test this patch:
https://lore.kernel.org/selinux/20261102130834.253605-1-omosnacek@gmail.com=
/
