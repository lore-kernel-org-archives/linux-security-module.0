Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793632469;
	b=x7BOgMvSLQo2l4Hdv1vl/Q7VYUfRddVws4ohE1rrGgfkXEqWFO//8735NUBd8XHHPy1E
	 LgypeGWFMT8BoTVYHQVGTPqYzEkkGx9BrHaqSOPTU2fnz2p9GKgKiLL4+UCgNRm8vWDVJ
	 B3w/K65Z2Fz15Kk+z49qFu9za+saf95rF0c/9MPcgW7DIYBdA6I7PVtvlk3Nf8OHqdjeJ
	 w2hul8X6cV4AeAtcFuumG2n0hNzjsWEMW0aLmGx7OkT7rIJzTvpva/+tak1ebheW38qw1
	 F5Ol3GxR/xNCifquU3SfLFXjC83v3B1ionlPTJb+mFXxjG+m20kcbr3dF8axAivgZoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=aOdCxZO55hUw/6I077tI6EL/o28ur2wlUbUGRR4UyJU=;
	b=YlkgtFWEnwsdX8Qij6Jd9gCvwIUVdFnd3pV/e6B3MAq5ts7nuEBECCl4IXrhoQuiEwxW
	 LpHYnoy12NeIa7rdXPRZKFhc8vhp/RKcbLpZju8cgwg2/i23HmqNJr1OnePTjEXV8lSAD
	 cetOpElv3SLmgsfzOQgJ1pZOose7GBHyfWDS2YIsRl2qeGPzlNs+YMsDUZ/cR6I+eX3Jw
	 og2kXMrJt5w40wti80Q1K+6eQEWNGdBiUpiI2TwdQAqhGcDpQP0I10/LJsykXYi+41w7S
	 4yDk5tlIAVGtSRQ9owGAj+UwS9V0fi12Q0yZcWllhPoR3Dqf9WtEfOdgyF0hhSy9MVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="UK/Ov2Zm";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68209606E020
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 15:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68209606E020
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UK/Ov2Zm
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-67b9bd530b7so2053946d50.0
        for <linux-security-module@vger.kernel.org>; Mon, 02 Nov 2026 07:14:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793632468; cv=none;
        d=google.com; s=arc-20260327;
        b=PWLn8Ae/2rnp7HQDmOOmCokNlGwZu9/FzYOzJHdJsKzT8W/xdlCdVZzlnHrMZJjaOU
         tOuruDyo0fZ3/bZQqZv91kO1oyXC+ZNHdWsCvWXL/POjDIBXv9g8sBFXSW21a30s3CjD
         L0srATV80/KxZ4KojOomrtUVcvea1lRIsL4wYEWGbmL90yizWU5+itZFYUwpNpplNku7
         tgm0sUTTWq4gWdXxpBXUX4yykFoce/LpTsMsIN+jH0Yu+stILdpk1XZ/zwoAlleLPDIh
         5ZW2GdxjvU9vK0DMEeK+vGrxnsmNCKeNa7fVuqwfaZ1fxz57YlYS7l51fmNJgWXrCD1L
         5SgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aOdCxZO55hUw/6I077tI6EL/o28ur2wlUbUGRR4UyJU=;
        fh=34miXD1lnlte6KGI/CFPEfDfgH/iQzvBfn2mJyU20oo=;
        b=Xn0DKG5Guw8+24QC8yq8ezqfF7itTPiFlG5fK0MgfUz9SPKDW/qTOj+s9NVxs90lVa
         wZImMokikjEIm6KwIf21wp49Psll1niHRI3Rq13UHJbm+JTFZdZnAS0eNT4ONC8BijDE
         oaTs6ISaO2LLyLfwuVAkGr9EHIUMQ3AmOyq8/i1yGu8sHmDy/agnvsMD6aYvFrSTDEPZ
         wu/8ICTgwHBq060wLAJ+vMxNYsv7FlaQTt+c8QuHbr9/Uxpj7Eg4WkKeB41t+3msq3Dy
         UvF5YHYg10syqcORhFm/yZbb/49KPOPwKkmdE+MLBevwU58CG6fgI340+uHIV/RMWysW
         Z70Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793632468; x=1794237268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aOdCxZO55hUw/6I077tI6EL/o28ur2wlUbUGRR4UyJU=;
        b=UK/Ov2ZmZrdzn6wtpyN4IuP0s2NI94uQI7yYBJibP6aHf1CPcffmPVYaLkzYSc7pZm
         Q+awmbVw7SIAx9igzH2GxMbpkJkUZWNm5FYtB1KlYDTmR1d4BJDrwn+eZuXuDN3hfkKi
         wic6ZSVgM3Y1UqylgTszFO6RuIHOCzlfX7DyBHr6w+fBZfeaHkL3L5lbBc4iRYJCXspt
         9pzWytIy2fjqQ7RVqjA8Iyg0vs6YCR+ISjcat8IZewOZC+HDkTF+GC7SBwr94lTftIlb
         iXOhyfTyOpSiHWGkM8CQhvl9wo0AmvYC/zHu1qJMn7diEAHe+U1q3JmLq16spCqaJO9l
         ToNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793632468; x=1794237268;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aOdCxZO55hUw/6I077tI6EL/o28ur2wlUbUGRR4UyJU=;
        b=woPSHoXbnkvHQJ946QSUOoZSf/kumjKwuGfGgBH2NpwwyDV6rtqBPEyx6dw5hfNeyJ
         F6dyv++uxvk90ycqVqQ0Rsf84B3Qko4aULpY53JUxLWzkZ6bbq1Zpl9eaXrx/vkQWIai
         aqYTXIfNO6owKEi74zOWfyd9zr7DOkRJfxvoFLyLT7SZHyBpmoeNszvPPvUYUFr7MC42
         WfdEH2SvCQgD2XbpYCMzY6v7pqQAFh//+jxp7tP4Kaj1liQJq8xhYcN+6SgjlKk1UOgI
         qy9orIpQ/CU4eSh7RxlFvbH9//1U0SYFUFMGUH4M1ejNCWPj0pFMPYKbkPmZ9ozET8rp
         6Qcg==
X-Forwarded-Encrypted: i=1; AKwUvBxT21PUSGNGxUtmK819EKiYIEe1pCXGyMLdSkrjbre+4q/6ivRv3xcO0O52fVDK789wgAInV+CkgGgBWb+kAbXmW4vEeVg=@vger.kernel.org
X-Gm-Message-State: APuU4Z87jVJEzKw5XF+R2Ax/Sbya5eoaUk+j1Q0hIaXR7in+Jss3D7Ww
	//DwU2q+R9b9mXIDoBGruINR3T1A80abi5j3z8Mr7w9Vx0cH67J0QEDeok8oxSzbMV0smztHt8n
	zwbuNfyU2MyoFTc8ct3XtlJPCyX3+yog=
X-Gm-Gg: AYBFou0GgPJAdpFzE/cVFRYhpbNgiYqT8rhL9MhztFGR+Ko0sTWjRl5mUHshEMW/Jq2
	gDmVXjSs7d4/AvFAiDJKhh+cI/v5J1OSL9LlpaGZq9ZrV0Exq7Kp8DMj+D0pGlTbDW5Lw0FIePs
	0pSHNlG4UKk+fsjfiTof1KHrITGMe4v7J983vphQqzjxIdFOhVzuoSg4TMrWw3DeuHKHycP+NKP
	Ls9MzXmTOA3dL/vUJ/OtlsR3qg+FftNVWQNMQVN5/4OoMRABvv+NvLyRFugBjrG7VuZopi+N/6Z
	dDyWLRtuviWlw962J0X3yN//hMbzcVoslsix37VCclJwC16N0putP96qaNfkTwcAhNj2Cc2J4k1
	SQWyQ3HXmLrufCNhe9oKQ7lEWsg5a4A3blqsWGrVWACeIIJDLlX6MicJIZJYZsy9xtDyKBttVE5
	Mq8vP01IVP6CcMh2omzDXbWxEJ0GWJNwHvmRjVBlrvm/xfzpOnc62dUVEMwg==
X-Received: by 2002:a05:690e:1201:b0:679:28ad:d8d8 with SMTP id
 956f58d0204a3-67ba5118897mr8055833d50.104.1793632468374; Mon, 02 Nov 2026
 07:14:28 -0800 (PST)
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
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 2 Nov 2026 10:14:17 -0500
X-Gm-Features: AclHuK_S3LwuvSZEIcs1e2WEC4WgX3S0M8bKoabDzHzf2mxELuht56K17Z9rPEg
Message-ID: <CAEjxPJ4hxdvV-r8chmF3RAi9RJX=-4AqntG01=fWUhh4-xP+ew@mail.gmail.com>
Subject: Re: [RFC PATCH] af_unix: introduce MSG_CMSG_SEALED
To: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	netdev@vger.kernel.org, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 8:05=E2=80=AFAM Ondrej Mosn=C3=A1=C4=8Dek <omosnacek=
@gmail.com> wrote:
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

> diff --git a/net/core/scm.c b/net/core/scm.c
> index ae38f3c1165c..08822b2a1f22 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -114,10 +127,29 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct=
 scm_fp_list **fplp)
>
>                 if (fd < 0 || !(file =3D fget_raw(fd)))
>                         return -EBADF;
> -               /* don't allow io_uring files */
> -               if (io_is_uring_fops(file)) {
> -                       fput(file);
> -                       return -EINVAL;
> +
> +               if (sealed) {
> +                       /* Only allow sealed files */
> +                       if (file->f_op !=3D &envelope_ops)
> +                               return -EINVAL;

This leaks a file reference.

> +
> +                       file =3D (struct file *)file->private_data;

This fails to take a reference to the underlying file but will later get fp=
ut().

> +
> +                       /*
> +                        * No need to check for io_uring files here as th=
e
> +                        * underlying file had already successfully passe=
d the
> +                        * check when it was first sent.
> +                        */
> +               } else {
> +                       /* Don't allow sealed files */
> +                       if (file->f_op =3D=3D &envelope_ops)
> +                               return -EINVAL;

This also leaks a file reference.

> @@ -365,18 +398,37 @@ static int scm_max_fds(struct msghdr *msg)
>  }
>
>  int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int flags,
> -                   bool notrunc)
> +                   bool notrunc, bool sealed)
>  {
> +       struct file *f_received;
>         int error;
>
>         if (!ufd)
>                 return -EFAULT;
>
> -       error =3D security_file_receive(f);
> -       if (error)
> -               return notrunc ? put_user(error, ufd) : error;

Design point: I would suggest adding and using a new LSM hook that
allows security modules (like SELinux) to still be able to check a
(new) permission that governs whether a process can pass along these
sealed fds so that we do not entirely lose control over their use.
