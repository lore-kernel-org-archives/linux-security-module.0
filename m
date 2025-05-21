Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B73442C
	for <linux-security-module@vger.kernel.org>; Wed, 21 May 2025 21:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747863093; cv=none; b=CbM3ZxfBMpqbpbd8s683MzjF5qaldLyUm+qIZgNsXA1fgdyXOjokosh2W1u6OdGiEAvAnm0Emht1dOIkOw1GPmk6PWoktBByL1JcszUiEtUp67I2lxJXfaptjA1DFlOfRK7/hqoFf0FtNgU6ytWLqmGNbHtwUOtkkio3CHlZhHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747863093; c=relaxed/simple;
	bh=744hrUQyQaJMNhXZ+MAkzT2DXCCzspRedhlx+Q/u6bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSUidYi00J7ykBCKwtbMF2n6EGc3a/lVu+x90JWHitDVKYdGHAgRJ+Dh4X33tZJilqYWQKvX2N6s9Zw1VVNlAJ3AmiKNRDjwdAECJiPGxXmm7AI11iU6q49eFwWLr8/o9TViAxMk3HmK3X9iaexFGhSxnc5l3F3/X07e435JARU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KBpH34HJ; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KBpH34HJ"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e7b3178473eso6902256276.2
        for <linux-security-module@vger.kernel.org>; Wed, 21 May 2025 14:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747863089; x=1748467889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GXwy1kEW0JPOOxOeszLkv5sZ9JO5M8aq65wgnslF0c=;
        b=KBpH34HJOdXHJLvqmWENXqJJ9nfjfOunsY4+KIg4hS5DuGnPwbb5URdzt0bgIClDET
         M4gPV9RkLGx4W0Y7M5QS8XwBwA/H0fGWCCT4zGh9eFV8auRDqeZyiY7CA4IpN6/xjWcO
         /lYBb6pUt1aRmAwfbW485TfYuFljyzc1CSySp3TpNXrqfNsEKqRJq9ReSErL3pQLaDTE
         uK+uOrEeGuxWrS0zl1UAI2+xkaqIWe90q0pveoqb8cHuHMMGOnIjRP3/vmw+SBXie2+B
         tA6H6hPS5IXkLP/omAsQYq3MTfrYzKgc+HHxkYtpLO/Fw/hxS2r14vUPh0chtZVUlGvc
         lLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747863089; x=1748467889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GXwy1kEW0JPOOxOeszLkv5sZ9JO5M8aq65wgnslF0c=;
        b=RCRTtB0mhkpAtgb4pPcyrBp4GZStXrmMHstYzqina2+V8mOOMZsx82gRNe73KNtYCZ
         F1Akb8VXVXDc/wTre3Wem9y11zAlr/VWWuevQgZRyIaT/SEi9NOJPfaoIZWxYo+Pg66w
         gIOeXNR7qE1exIQOyWLuuCqP2s7oEptFdrDWSfsDrJxfK+hzGJhqkAhHl0Ll8vzN8tBa
         t1IHsZtcptm+ZsJbOt7VgDbvhaSzM7UAVNXDvlTraR9N1kfWJ/mDbYZsbTcSvsQx0Uh2
         gD41fIQT/L71E5Iki5zlNQGIWthArYxiIwc1+BvwM6uVjsnejGr++3R9+jZNef4t4+n9
         uqGA==
X-Gm-Message-State: AOJu0YySvkeWrfYM0GlJUACDGoOfN3AL/QZc0u7DRHHDqt0oJrJn03Ya
	X+OIAjtk8DQYCJHeQ2/C7HI8x6rbp/Rt2dmZllK/DgNiARGSP4ZALsYVNqcz/KejrUjt7lX+WVc
	DJNt0xDmiXuA9V0JGpPED8UHRrHRveVRhiK9PA/DM
X-Gm-Gg: ASbGncv0vSVR61WhKNXnFQOKrxbAg/6SLEvai5ZmM0fByHvoc4TMnBR8Z7bV3Oa12vm
	/iyW0gczqzoN4Ws2LpZ8u4ZPpLfd+PVVIKPpN2ddb5qTsvYXrjoCG2F8hybwhwD8DDY1zDR7wbZ
	vZPO7PCRIr1apwbCcgfkp9fS+q6erf//ihFBdBxJM6oS0=
X-Google-Smtp-Source: AGHT+IFsYU17SnFlApxMikYlVjFydencW9RzKNz42GYdg5TTQEnzoKQH5AwgNW/rQbr1eW4h8yf43+YFkMVJaFGJLCM=
X-Received: by 2002:a05:6902:2411:b0:e7b:6768:1d4c with SMTP id
 3f1490d57ef6-e7b6a1fd6e3mr28236771276.36.1747863089482; Wed, 21 May 2025
 14:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521140121.591482-1-git@nightmared.fr> <20250521140121.591482-10-git@nightmared.fr>
In-Reply-To: <20250521140121.591482-10-git@nightmared.fr>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 May 2025 17:31:18 -0400
X-Gm-Features: AX0GCFvNcVqRgFYOLi4D9FncLR4G0u1aE30z5MYv_qx60lOm2NGbhIkb6anmQLY
Message-ID: <CAHC9VhR-80zxgo+q07Aw8HqK+qiPdnuXC0axONGac0e9JxXvmw@mail.gmail.com>
Subject: Re: [RFC PATCH 9/9] Loadpol LSM: add a minimal documentation
To: Simon THOBY <git@nightmared.fr>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 10:03=E2=80=AFAM Simon THOBY <git@nightmared.fr> wr=
ote:
>
> Introduce a minimal documentation for Loadpol, presenting the policy
> format and the two user interfaces: the securityfs policy file and the
> sysctl.
>
> Signed-off-by: Simon THOBY <git@nightmared.fr>
> ---
>  Documentation/admin-guide/LSM/Loadpol.rst | 81 +++++++++++++++++++++++
>  Documentation/admin-guide/LSM/index.rst   |  1 +
>  2 files changed, 82 insertions(+)
>  create mode 100644 Documentation/admin-guide/LSM/Loadpol.rst
>
> diff --git a/Documentation/admin-guide/LSM/Loadpol.rst b/Documentation/ad=
min-guide/LSM/Loadpol.rst
> new file mode 100644
> index 000000000000..0aa24a8d393c
> --- /dev/null
> +++ b/Documentation/admin-guide/LSM/Loadpol.rst
> @@ -0,0 +1,81 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D
> +Loadpol
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +Loadpol is a Linux Security Module that enforces a user-provided policy
> +when decided whether a dynamic module can be loaded or not.

Considering the relatively small scope of Loadpol, I have to ask if
you've considered augmenting other LSMs to meet your needs?  While
LoadPin is different from what you are proposing here, it does
similarly limit its scope to kernel module load operations, and given
the current simplicity of LoadPin I imagine one could find a creative
way to extend it to support what you are trying to do.

> +The policy can be read and rewritten at ``/sys/kernel/security/loadpol/p=
olicy``.
> +
> +A default policy is created that contains the current list of blackliste=
d modules,
> +and a catch-all entry that allow loading any module.
> +
> +Policy format
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The policy is defined as a set of line-separated entries.
> +Each entry define the conditions for a match (the origin of the load req=
uest and
> +the name of the kernel module), and the action to take when the load req=
uest
> +matches the entry.
> +
> +
> +Entry syntax: ``[origin=3D(userspace|kernel|kernel,userspace)] [module=
=3D<module_name>] action=3D(allow|deny)``
> +
> +There are two matching conditions:
> +
> +``origin``:
> +    Load Requests can come from two origins:
> +
> +    * ``userspace`` (ie. a program in userspace called modprobe/insmod)
> +    * ``kernel`` (the kernel requested the module directly by calling
> +      ``request_module(...)``, e.g. loading a filesystem when performing=
 a
> +      ``-o loop`` mount).
> +
> +    When unspecified, the condition defaults to ``kernel,userspace`` (wh=
ich means
> +    that both origins match).
> +
> +``module``:
> +    Name of the kernel module being matched. The name can contain wilcar=
ds.
> +    Beware, module aliases do not work!

It would be good to have a section in the documentation where you
discuss how the risks inherent to filtering on the module name, and
approaches that can be used to ensure that a malicious module is not
simply "borrowing" a known good module's name.

> +There are two possible actions:
> +
> +* ``allow``: permit the load of the kernel module.
> +* ``deny``: reject the load of the kernel module and emit an audit log.
> +
> +The policy is not greedy: as soon as a match is found, the evaluation te=
rminates
> +with the result of that match. So be very careful with the order of your=
 entries.
> +
> +The main use cases of the policy will probably be to define an allowlist
> +(here, we allow ``module_a`` and any module starting with ``module_b`` l=
oaded
> +by the user)::
> +
> +       module=3D=3Dmodule_a action=3Dallow
> +       origin=3D=3Duser module=3D=3Dmodule_b* action=3Ddeny
> +       action=3Ddeny
> +
> +But other mechanisms are possible, like a denylist
> +(here we block ``module_a``, ``module_b`` if it is loaded by the kernel =
and
> +any module starting with ``module_c`` loaded by the user)::
> +
> +       module=3D=3Dmodule_a action=3Ddeny
> +       origin=3D=3Dkernel module=3D=3Dmodule_b action=3Ddeny
> +       origin=3D=3Duser module=3D=3Dmodule_c* action=3Ddeny
> +       action=3Dallow
> +
> +Policy lock
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +In order to protect the policy from tampering, a sysctl is provided to
> +lock-in-place the currently-loaded policy.
> +
> +The ``security.loadpol.locked`` can take 2 values:
> +
> +0 - default:
> +    the policy can be reloaded at runtime by any administrator.
> +
> +1 - locked:
> +    the policy cannot be updated or modified, and loadpol cannot be disa=
bled
> +    without rebooting.
> diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admi=
n-guide/LSM/index.rst
> index b44ef68f6e4d..01d36670d8ad 100644
> --- a/Documentation/admin-guide/LSM/index.rst
> +++ b/Documentation/admin-guide/LSM/index.rst
> @@ -42,6 +42,7 @@ subdirectories.
>
>     apparmor
>     LoadPin
> +   Loadpol
>     SELinux
>     Smack
>     tomoyo
> --
> 2.49.0

--=20
paul-moore.com
