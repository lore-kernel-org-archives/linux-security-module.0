Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kn9vu4CK"
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42543D54
	for <linux-security-module@vger.kernel.org>; Fri,  1 Dec 2023 11:55:16 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-58d54612d9cso1449122eaf.1
        for <linux-security-module@vger.kernel.org>; Fri, 01 Dec 2023 11:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701460515; x=1702065315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTTNStoC/SBWn8ddyapjmmJsurHnXRBGBUWEcKhY7Qw=;
        b=Kn9vu4CK9UaJKIp3gRxThqq4T5vaRZsXT/m6aNULRT4YmXZJmt7sRkx+PBsqSUSVjv
         EYV5XOO0VYNGU/15/aTIOkeFQUBfhdJQMq5BGj+dh43XTfLdHMy6tHc4O6N/0eao+esU
         j0RF4iwiHbr/ZhOln6YM+bl1JTBMr21VaY9GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701460515; x=1702065315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTTNStoC/SBWn8ddyapjmmJsurHnXRBGBUWEcKhY7Qw=;
        b=XJRbVDhszduEyfp5shVrRsSv/hFe6X+3bPIbUFOLleiR0eLDne5gEzlDZdEEbvRRHE
         NPOeiPmKye9AN2TbGdk/3L1Cj+QHNoCdOMqTlRgqb0cWGrdGb8TRHEXHN7cFwLTfXLqy
         7wtucN7fkAJQuXU7Te9ajPnzSJKNeKoSpBBWv5rLKbtV9CYVpYalMmxHtrzPu2cW6K8g
         Cneds0HR74HRtPUPiou+aezzCLlRtyO23AsNdtawFr/D3a1QEFx7AK//4wxbilt07uKD
         PTYN2HSIfwBS4HaiDCTBINAaH8naHkVJAl6I1XD13VGEmVQbBRsn7qtu74+bFXzUm1M0
         6iyg==
X-Gm-Message-State: AOJu0YxUdptk1i9It8q8BfU7s7FPyrYxJnMQBZs+2siaaWm1esfVtTSG
	F8JCVophfUMmlUGwpI+8wzx8Y9VysXsIPrDJEae3bg==
X-Google-Smtp-Source: AGHT+IEIpu7Fm/q6q7G8jo2n/JQ2rETgukYP7FQ5Z0X+Zk8nLcZ0x+yTcWzE/AaxyBNSEwQO/rosIOfOjR8obPW9ou4=
X-Received: by 2002:a05:6870:548b:b0:1fb:75a:c434 with SMTP id
 f11-20020a056870548b00b001fb075ac434mr30221oan.93.1701460515604; Fri, 01 Dec
 2023 11:55:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201143042.3276833-1-gnoack@google.com> <20231201143042.3276833-10-gnoack@google.com>
In-Reply-To: <20231201143042.3276833-10-gnoack@google.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 1 Dec 2023 11:55:03 -0800
Message-ID: <CABi2SkULCFBK0eBZen6Z7YSLnm_EcZqbmPN2fQ64bBbmX77uRw@mail.gmail.com>
Subject: Re: [PATCH v7 9/9] landlock: Document IOCTL support
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 6:41=E2=80=AFAM G=C3=BCnther Noack <gnoack@google.co=
m> wrote:
>
> In the paragraph above the fallback logic, use the shorter phrasing
> from the landlock(7) man page.
>
> Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
> ---
>  Documentation/userspace-api/landlock.rst | 74 +++++++++++++++++++-----
>  1 file changed, 59 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/use=
rspace-api/landlock.rst
> index 2e3822677061..68498ca64dc9 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -75,7 +75,8 @@ to be explicit about the denied-by-default access right=
s.
>              LANDLOCK_ACCESS_FS_MAKE_BLOCK |
>              LANDLOCK_ACCESS_FS_MAKE_SYM |
>              LANDLOCK_ACCESS_FS_REFER |
> -            LANDLOCK_ACCESS_FS_TRUNCATE,
> +            LANDLOCK_ACCESS_FS_TRUNCATE |
> +            LANDLOCK_ACCESS_FS_IOCTL,
>          .handled_access_net =3D
>              LANDLOCK_ACCESS_NET_BIND_TCP |
>              LANDLOCK_ACCESS_NET_CONNECT_TCP,
> @@ -84,10 +85,10 @@ to be explicit about the denied-by-default access rig=
hts.
>  Because we may not know on which kernel version an application will be
>  executed, it is safer to follow a best-effort security approach.  Indeed=
, we
>  should try to protect users as much as possible whatever the kernel they=
 are
> -using.  To avoid binary enforcement (i.e. either all security features o=
r
> -none), we can leverage a dedicated Landlock command to get the current v=
ersion
> -of the Landlock ABI and adapt the handled accesses.  Let's check if we s=
hould
> -remove access rights which are only supported in higher versions of the =
ABI.
> +using.
> +
> +To be compatible with older Linux versions, we detect the available Land=
lock ABI
> +version, and only use the available subset of access rights:
>
>  .. code-block:: c
>
> @@ -113,6 +114,10 @@ remove access rights which are only supported in hig=
her versions of the ABI.
>          ruleset_attr.handled_access_net &=3D
>              ~(LANDLOCK_ACCESS_NET_BIND_TCP |
>                LANDLOCK_ACCESS_NET_CONNECT_TCP);
> +        __attribute__((fallthrough));
> +    case 4:
> +        /* Removes LANDLOCK_ACCESS_FS_IOCTL for ABI < 5 */
> +        ruleset_attr.handled_access_fs &=3D ~LANDLOCK_ACCESS_FS_IOCTL;
>      }
>
>  This enables to create an inclusive ruleset that will contain our rules.
> @@ -224,6 +229,7 @@ access rights per directory enables to change the loc=
ation of such directory
>  without relying on the destination directory access rights (except those=
 that
>  are required for this operation, see ``LANDLOCK_ACCESS_FS_REFER``
>  documentation).
> +
>  Having self-sufficient hierarchies also helps to tighten the required ac=
cess
>  rights to the minimal set of data.  This also helps avoid sinkhole direc=
tories,
>  i.e.  directories where data can be linked to but not linked from.  Howe=
ver,
> @@ -317,18 +323,24 @@ It should also be noted that truncating files does =
not require the
>  system call, this can also be done through :manpage:`open(2)` with the f=
lags
>  ``O_RDONLY | O_TRUNC``.
>
> -When opening a file, the availability of the ``LANDLOCK_ACCESS_FS_TRUNCA=
TE``
> -right is associated with the newly created file descriptor and will be u=
sed for
> -subsequent truncation attempts using :manpage:`ftruncate(2)`.  The behav=
ior is
> -similar to opening a file for reading or writing, where permissions are =
checked
> -during :manpage:`open(2)`, but not during the subsequent :manpage:`read(=
2)` and
> +The truncate right is associated with the opened file (see below).
> +
> +Rights associated with file descriptors
> +---------------------------------------
> +
> +When opening a file, the availability of the ``LANDLOCK_ACCESS_FS_TRUNCA=
TE`` and
> +``LANDLOCK_ACCESS_FS_IOCTL`` rights is associated with the newly created=
 file
> +descriptor and will be used for subsequent truncation and ioctl attempts=
 using
> +:manpage:`ftruncate(2)` and :manpage:`ioctl(2)`.  The behavior is simila=
r to
> +opening a file for reading or writing, where permissions are checked dur=
ing
> +:manpage:`open(2)`, but not during the subsequent :manpage:`read(2)` and
>  :manpage:`write(2)` calls.
>
> -As a consequence, it is possible to have multiple open file descriptors =
for the
> -same file, where one grants the right to truncate the file and the other=
 does
> -not.  It is also possible to pass such file descriptors between processe=
s,
> -keeping their Landlock properties, even when these processes do not have=
 an
> -enforced Landlock ruleset.
> +As a consequence, it is possible to have multiple open file descriptors
> +referring to the same file, where one grants the truncate or ioctl right=
 and the
> +other does not.  It is also possible to pass such file descriptors betwe=
en
> +processes, keeping their Landlock properties, even when these processes =
do not
> +have an enforced Landlock ruleset.
>
I understand the "passing fd between process ", but not the " multiple
open fds referring to the same file, with different permission", are
those fds all opened within the same domain ?

Can we have a pseudocode to help understanding ?

-Jeff
