Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545D13A1A58
	for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 20:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790366454; cv=pass; b=Ah3hq7BNhzb6oBlEEp58wsPQl5mfaRhkgIZxkn0UWZm2mbuY0slB7O0seW3nVBnXIlo41cfZ6rGyWWpuM/JDp4IEMmNOfRHo+D5yUYhUDXNgFAzYyniBH8HXmvwye5uJSctsEMxv0f6TkkSgyf1dvYRJXMso+mg99gwEt2ioMCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790366454; c=relaxed/simple;
	bh=4FQImKMswil5Yf4qU3iL4HP635uKtAuGj+q4LcLbdU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4Ztsv7Pycn3nCqcFv6Y4a747JAaTQbvvAkNu5HuCHuJpdqCgvWi6SWHsOTsC2Dj26CUPEIxENP/LEX32Vu4fnb6FAz59zSmEqxR3+d+C3QxhbQaVkdosIJ9o7KtFIWFrSR2mTIukfEH61V7gsc3H9C35KAELWMHzDsKjpCPHU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=A2f+0RFL; arc=pass smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="A2f+0RFL"
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F20B53F91E
	for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 20:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1790366444;
	bh=wG/i9tiTp8ePesopRc3qMjTf5qhlfbVXuwOQ1MTUCQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=A2f+0RFLeAi9qAzKOYbP/mRsUfjnFThMSCJZxQvb5RtzZu9dVud5LRqNj7FRZvXfo
	 xV/ARj28aH1e48NKug/jB0pEk/zeE8w552uqPo+o2C6WAwHNcIsl5jBIuclq50D//3
	 kSpH1TGoCHor05QmKqyX02tXfLzQ/d7WI2/yDY5FWkNbd3wi7rKp+e4JNa+tMy3C5w
	 YZr9kWvDjNXNw7HJLefXQ7AFcf/UXSNIkmiaE3XVnmd9sy8LqniyUfyqD7JaULP/Kk
	 GgVZi3dMWMnpPJxAAGvPH2ycLkzQJ9EZ8WFxE9SNESx4X+NynANmwRTerAQHzUTs3N
	 9oFfLywk96C9IOomGbmIraBv9z9PPajm0CI71dMc2TXA8M6NSTy/gIGb3bzFv3Wg1K
	 QKPOPNjXb43H2QNsxT2vXtPfRvyA3HjJAdjEfzAKaA8TNyP+r4tj2MymJriPyYMp9L
	 o5LsvJGUCgZRLz4+XpklwcpZj4uv+ebYqS/+NW7W9wWCO0JLNgcLQBAZVuxkq4+qc7
	 gN2W4gHXSOzWhMJSOjtZTKsvfjyGCuu/Ef0irF9P7hvZTQaIQDRuXb/nVWZ45zvGUG
	 ROoQFn5oeWoMvgzalU+wXStVDanApYiWkzxPJth8B8/WrXtB+8HGg5gEV0R8cQlc18
	 XCmuCcCf8PT1rikT69177iYw=
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-66c73057f18so1348367d50.3
        for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 13:00:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790366442; cv=none;
        d=google.com; s=arc-20260327;
        b=Xydxuc12IZyM+PT0O/suAB7tLUdqUebZauudWlSWC2xM9OoLgu7+83m9rdFeGjvgj6
         Vii72duwpkxl6Q5f3tH1YOEKko370WIhgQezq4j07h3zNoocpIsPorIOm3xcxbmmbry4
         eaU+0nfY9sAOE/yN1MzC0lQC9I4MNV8KamPwdyd1qYhzAciIZ3JjrrBYeX29CYGv0YHM
         IVHDvfrLSCJOGPKb/mWPIF5DjmOYYYR8sYSYWtFuuYsZ5v4qXe9cqz2aj9Ytz841vry9
         FCgKrw8613cCXThfRYp87KQeR3Xrvch1hNaGDRNdDXwXWoo4h1OXURcWmZIbLIOPxlby
         nP0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=wG/i9tiTp8ePesopRc3qMjTf5qhlfbVXuwOQ1MTUCQ0=;
        fh=MsFl3BTrxNNED33Zkqoo+PrHvNUAGyn35gt0LfJuIM0=;
        b=b4uDTo+XcgdwwIRcW1a5LPCqSery8Y7SoKNvcFuidgR+BNi61BINGk2RE2YcOw9XVe
         g6lum9aWX4NlZoZM21NzPvL/MYoZSOrvowKspPYakyfJ2MqNAoIOz+c9orylWm41eWSW
         0/9H8gpDy6Sor5hsFSSepPbDus+eN048b5t1qeRRJllfgcJjqlRRSOYL0DhsJX7eNrUj
         ljzJ8gtFZ3AMdpBHPcfsN8lrkviF5R2hTaQBflp9CHU3/qkYOtIhbvYBiaaA27KyILaG
         u2v8EWb//bHqvBuHBFvJEvBO0kCusAttRIWvKf3DPciebBfHRziNUiMgCtE/3OqSl63V
         ap3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790366442; x=1790971242;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wG/i9tiTp8ePesopRc3qMjTf5qhlfbVXuwOQ1MTUCQ0=;
        b=J5tJ4/1biq15AWGAJVMaawnQepceR68eDZxSQlJVNIHfQ02NXQzhcQIsGedIV6d0Kj
         L6SuasBrBH6GsHlorvBPfGms81XRmzc5i/mWmjQI+yHwGA9VrQNJnylV+xA9iDYJVqRN
         MbXJsX2PcS0W+Zis9kMjbQqbwM5jEwOOnhO3pq6A+CQm55gY7/vgZKx9CPiLwT9SDs5/
         3qjiQrZE+I+0iosv3HiG3CTW7JRkgOU37Z4ZtLE9rdX7cih0MV4kvSRQiPswZnzTgt3F
         81+9m75TQIe8KbvXJaB/FnJWyMo1TCAearND9EBG5vX+tm9uJbDPJeX8BVXN3Tv91A1R
         I2dA==
X-Forwarded-Encrypted: i=1; AKwUvBzR44opYqMandSavW4hFBO5mR25LOzndl9gHr/PhWbF+7Qr/lur6Kmd/FtKNP4Vmpz5DS+tCvxTaeVH4DBTjc132T7OS2Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAzFSefnq4oz1YUmlIBirtE0uhAGvA5nqWGqJVVY1opAxZsiwW
	XXEQOAqJpEdGB3X8k2i9b7eaxkJXUBn87KWl90ZAZxAGocRpmOnU3Ha6RJQKb6WTeKsxgg/GqpM
	kFfiUkL7n4HniJOGvHCtew+32yx/CwgfswataMNaKuBnjgjXzej1wrBgdIEEhiZshUywFftU30K
	DNF746OEPbxYh1t1gjVZznxsScdo0AULcV6boR0RpioVfGn5SLAts38FELC1aQRI2H9E3t+iVh6
	oQdwHo=
X-Gm-Gg: AYBFou0A06MWJSG/yJMB1VtyilYGiqsefAORqCv35z32ZHLctLiqCgVSVE48xkSgNZw
	cvnV1g2ulqzyc2lKv2ckCS8GFtR2AS5a6nBlkJ169iSTn0OUOajUsmO5B1wBJDYldKPGTf7EfHa
	J2e9RkQoX5ZlidLeYi/kCW5ZAIfRh1xR2HY6q0A8rroGnLnF1bGmCdMv+3obIEFj5GRvoS8E4h3
	ofpS4tXEFoxZ37Ux5AdJ1gmgZAltihxbBHlZP/9gSE=
X-Received: by 2002:a05:690e:1349:b0:674:1e39:446 with SMTP id 956f58d0204a3-6741e390a77mr479898d50.39.1790366442333;
        Fri, 25 Sep 2026 13:00:42 -0700 (PDT)
X-Received: by 2002:a05:690e:1349:b0:674:1e39:446 with SMTP id
 956f58d0204a3-6741e390a77mr479884d50.39.1790366441838; Fri, 25 Sep 2026
 13:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925193842.1208132-3-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20260925193842.1208132-3-Jeremy.Jean@oss.cyber.gouv.fr>
From: Ryan Lee <ryan.lee@canonical.com>
Date: Fri, 25 Sep 2026 13:00:29 -0700
X-Gm-Features: AclHuK_mOIA3FwKExSadHRMkzyxNL4pwM7I_MYyeQT-_8dlrK5CScnNC01wdXIw
Message-ID: <CAKCV-6u01ARuWLn3snV6fo=k-3LOVNdEkMux3NQmcj4X+vYprQ@mail.gmail.com>
Subject: Re: [PATCH] apparmor: check connect permission for SCTP
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 12:40=E2=80=AFPM J=C3=A9r=C3=A9my Jean
<Jeremy.Jean@oss.cyber.gouv.fr> wrote:
>
> SCTP can start an association through sendmsg() or CONNECTX. These paths
> call the SCTP-specific sctp_bind_connect hook instead of the normal socke=
t
> connect hook, but AppArmor does not register it. As a result, a profile c=
an
> deny connect and allow send or setopt, yet a task can still create an SCT=
P
> association.
>
> Register the SCTP hook. Ask for connect permission when SENDMSG_CONNECT
> or CONNECTX creates an association.
>
> Fixes: 56974a6fcfef ("apparmor: add base infastructure for socket mediati=
on")
> Assisted-by: LLM
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>  security/apparmor/lsm.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index d502ad0ac26f..dba078c73abc 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -15,6 +15,7 @@
>  #include <linux/mount.h>
>  #include <linux/namei.h>
>  #include <linux/ptrace.h>
> +#include <linux/sctp.h>
>  #include <linux/ctype.h>
>  #include <linux/sysctl.h>
>  #include <linux/sysfs.h>
> @@ -1405,6 +1406,18 @@ static int apparmor_socket_connect(struct socket *=
sock,
>         return aa_sk_perm(OP_CONNECT, AA_MAY_CONNECT, sock->sk);
>  }
>
> +static int apparmor_sctp_bind_connect(struct sock *sk, int optname,
> +                                     struct sockaddr *address, int addrl=
en)
> +{
> +       switch (optname) {
> +       case SCTP_SOCKOPT_CONNECTX:
> +       case SCTP_SENDMSG_CONNECT:
> +               return aa_sk_perm(OP_CONNECT, AA_MAY_CONNECT, sk);
> +       }
> +
> +       return 0;
> +}
> +
>  static int apparmor_socket_listen(struct socket *sock, int backlog)
>  {
>         AA_BUG(!sock);
> @@ -1823,6 +1836,7 @@ static struct security_hook_list apparmor_hooks[] _=
_ro_after_init =3D {
>         LSM_HOOK_INIT(socket_getsockopt, apparmor_socket_getsockopt),
>         LSM_HOOK_INIT(socket_setsockopt, apparmor_socket_setsockopt),
>         LSM_HOOK_INIT(socket_shutdown, apparmor_socket_shutdown),
> +       LSM_HOOK_INIT(sctp_bind_connect, apparmor_sctp_bind_connect),
>  #ifdef CONFIG_NETWORK_SECMARK
>         LSM_HOOK_INIT(socket_sock_rcv_skb, apparmor_socket_sock_rcv_skb),
>  #endif
> --
> 2.47.3
>
>

Could you also add a regression test to the upstream userspace repo
(https://gitlab.com/apparmor/apparmor, tests/regression/apparmor) to
exercise mediation of SCTP connections?
