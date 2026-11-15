Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794754480;
	b=qmLxC8pI4mrM8qjBMhEMJmgUuodUjIFYmpgrLQrNfu6XKRaxiBgDLbY0rdV6kKc7qM9r
	 1OWxMprG1p7o4feei0jQKmM+OA9DNbibsNfZQuolHsUGYArKmsg/du/c2pogyepu8OHzT
	 q0XfHi9aj7IPxsQ8jvfU34pASHEBXSY4lhtOgw4LRE1io1nsAgXlKCti4v4ykf/7t33tU
	 K5yqDL+LeOdW7ImBzu6V2YXVYJ2Ebz6mzWxzL2NgC4b69O8XiCAjza1EW2OUynd5Jcr/A
	 zn1cRLVQYgOxV0OxfXIuMgjyPDV2t/d32jy9jwn1hXgmznlc0lr+6qfWf3hpWHdsoOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oqISismNDREzK3BapMQL3oVfFqMKLBzQ11G0pwa4rCw=;
	b=e4llguFfucRyXSBvEF1Oie54RFGUVgowVn/5XdNqfTDiRkITQB6AKp7Y86m+xaVI8We0
	 1Uju2VGDM0aXOBdkfk03ynPHrSjpe63ytwQCf0ym2vycezdupjjQCbY7XGefcMd5zJm+p
	 I78ioamPIk9NM6SZgbWPtWyMD4u2yFQPf0f12q5+rGt/2mhtFb1nXuj/wjnzoGC36w8rR
	 x14o+f0pcd/WY1dzzyItdD3288nWwc1U67eCIObvAxoe/S6/D4tvRwneVJuaf6P/O9OZ2
	 VWgNzuIQSjMEuVI6G8buVk6bWJOHlcASRmquPIKdka3bu+qFiCQvWs0xUrpvGEZmSyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nene7tW5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5B3606A31F
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B5B3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nene7tW5
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so4336895a12.2
        for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 06:54:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794754478; cv=none;
        d=google.com; s=arc-20260327;
        b=kixTdG3QGCgofuGs9ThkZ9d/kk0sElXIJvTWYVEWno5NakiWh6DI4QNZeXeByy+bdh
         herUfokmLzWPT2i8y0ETDwV/ZsprLHZOyqjt1AOEhDn2gATyPjJ93elAqVmMuu6wkCP1
         sW//ljm0oi7pQFBpx/7JqGe9dpSB0Jz94wfGW673gURL/rKxGLYO2VYOVOL1eIIwWH/L
         p3buvk/fhfL8txWzRko2nkZEuXKDmaOcElTTQt8l3F8kzNXfJA+I/wGyGUdytf/1RK78
         PohC38+2pyuas+EAsmA5TuACemPri6vn/JksPnStvYX86vfLejeTwCQNNOkOZrTYqXwR
         yNwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oqISismNDREzK3BapMQL3oVfFqMKLBzQ11G0pwa4rCw=;
        fh=ICDrU/Z4DZfW5eqYxPbEtSZNAIMsawMDzcXIu1uXr8g=;
        b=CPA0lr9wy4B77I1wVF37N9QBnA3u/nrmUm4P3pjKtEcAfsdkuCBJiaCF4KUbclRFHS
         XTNiXUatCpvwaxBNF+xxMziiljVP0RJlkshZzd4vyMKPLZ9eSG/Ixfk2VpY4AAp5Waqy
         jGGhFcxCMuY5Z9Kdorz3oudwhY+dzDr9LXCcXtDWUXUvCm9BAKI49DB1mB+c+FC2uv0b
         rk2S2gt6JCe0hGqiV9HLZT59gfTvb1/Sh1iaFmgXYWyXy2roSfSlTJQMi2tI6gqtzTm1
         Wvk8KCwixAs533C+zoxDE4wbD485LegHWhU/OYAWyXWw+HYcP+IohC+hVsOsQW9eSO1y
         pb3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794754478; x=1795359278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oqISismNDREzK3BapMQL3oVfFqMKLBzQ11G0pwa4rCw=;
        b=Nene7tW5gi/n28xM9GPcsrsbApaftwN+5VLijlNSUx682MtoFHHSTEvDl1z11fpu1X
         HvQApdaPQrGfQyiS3FbYQVWjhD4Evwt6P0rS5BC7bOQTZVXFLWaPO4OPsg6ddRko0o+q
         9oJBo3AXuMJZvhtMaEl5yxlnDv3/Y+/ZTOoPRzC8SnU76nRTNG9VsBQOFmcVN+eTzILI
         pLq9xeN6fA01RGoB9NuHnqix3fuxZlQryfHYntRw18u5V1gyWgLisGhonGsU8L2T6Lkf
         J6bkZRN93M/WAUT22qxzPXNMWojuGB568xJ5NJFT1QuthxcS4hfC3ctLRiOXitSCJ+gM
         bTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794754478; x=1795359278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oqISismNDREzK3BapMQL3oVfFqMKLBzQ11G0pwa4rCw=;
        b=keAvJMIZEI02Z8RmZ2U/8HR5jsSWdvXxL2EKLciPy8PQ9x+6I7zHWRYhyr/EAuNQhx
         GC5PhtQ55Ixftp8gK5X46uo6ZbsvAvD2tCUL4lNYHn9aDNRb6alAUNRgxrnqA/s12zcn
         v3bkmJWQQTenntyLqs/Gh20gbp4Sc6c5F3OmfTq1w8E89v6Lkyj0bFbD+l+yknxLoqqj
         HRLvNxxbQFJb4cFOrd/Mf42UAJLzbWDX9yo//jV9JHz72nP8y7A/hEY2IJwCOqVEFZWu
         Lg06CUAzMZ1vj/CBBjEybh3/BBwLFRu05zY+fkHD265v7euQNw+97gem/IzBw3ys6LAn
         ghVw==
X-Forwarded-Encrypted: i=1; AL+hErG/MJUvsuDjyz7zdZGIknzOBt9zk3VpYrGdHZL4Qpnbmk5HujBRz5bAhzW7lRcnaQbgWPjXxJ1cHX512IDjnTuJegwW/aA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ajaOAxhGsoZw0t5thAnpAwTp6BcqgX2Zxv9d6xS+WYZd/iYZY
	v2aVL2pdXVJRZSaWvoSxgbK20nk9nlGfp0Gulmj6VMD0WBCQjTy/FrJDWNFjLhRsylJbOYSqWnR
	LPMnkhS1/5LEqPBlZSu42JFAlk/FIHcc=
X-Gm-Gg: AYBFou1ZzEioOErRNxhzYj5RWgW8/xN+gXU3NsiBsNUq4AplynZHpHnsHQIGlQT1AId
	n9idL1a/qDPofgWmeCvRsqxbz2EXkApgB2XYTw7VTOHhYcouMu9IbRbj3tC3tU4XgaQEOS7nwUK
	0owHFbUCqoQyqMVriJPj0WeUhjfrb4Be/aoaNG0KTddqfC/X+Hm1BW0qqSG26sirYbesnp0855p
	ugA6cBzETL6MuF5TNUzmmiKNU6II3SP3K7QvS/EjvS6HNbuMJ+4q4/zUXkFGsgsrbYLOsxPap50
	MweDGJgS3+V+TeizL75Fl/Cf9USlbTQnU7x7OTduDcRyXz1UCbx5XPn83sUa1nVSOZr583mjafy
	jA3t0Leyaf277h2HFwV4/ZlXgiJxhxMcyNp6zbkvEVGZeGze4Ud/KBQggGYeZA9kjQQBWQw==
X-Received: by 2002:aa7:d1ca:0:b0:6b1:c2cd:db0c with SMTP id
 4fb4d7f45d1cf-6b7c0957c1emr4306146a12.10.1794754478075; Sun, 15 Nov 2026
 06:54:38 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org> <20261115-work-ovl-d_real-v1-1-ca155efbcb2e@kernel.org>
In-Reply-To: <20261115-work-ovl-d_real-v1-1-ca155efbcb2e@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 15:54:26 +0100
X-Gm-Features: AclHuK8KXHVL-duO-F-YZ8XPwW63n9hxew9z3khJWwo4KtxA0bTnHEz-HW4OPxU
Message-ID: <CAOQ4uxhkqQE+ONrcgJNw2Jah59bKruxUAsLohTtKnsgTVQBw-A@mail.gmail.com>
Subject: Re: [PATCH 01/13] ovl: don't warn when the lazy lowerdata lookup
 fails in ovl_d_real()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Chris Down <chris@chrisdown.name>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-mm@kvack.org, 
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 3:02=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> ovl_d_real() looks up the data of a metacopy file in a data-only layer
> itself if nothing has done that yet. If that lookup fails it WARN()s and
> returns the overlayfs dentry.
>
> Commit 42dd69ae1af4 ("ovl: implement lazy lookup of lowerdata in
> data-only layers") assumed that the file would be read before
> trace_uprobe places a uprobe on it so the data would be there already.
>
> But nothing actually guarantees that. trace_uprobe takes the path from
> kern_path() and calls d_real_inode() on it when the event is created and
> again when it is enabled. So a uprobe on a metacopy file whose redirect
> points at nothing warns twice:
>
>   ovl_d_real(/f, 0): real dentry not found
>   WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210, CPU#2: sh/27=
9
>   Call Trace:
>    <TASK>
>    __trace_uprobe_create+0x1869/0x25b0
>    trace_probe_create+0xcc/0xe0
>    dyn_event_create+0x46/0x70
>    create_or_delete_trace_uprobe+0x3c/0x70
>    trace_parse_run_command+0x1a6/0x320
>    vfs_write+0x1cd/0xfa0
>    ksys_write+0x116/0x250
>    do_syscall_64+0x10e/0x5e0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>
>
> bpf's uprobe_multi does the same.
>
> A failed lookup isn't a bug though. The data can be missing, its verity
> digest can be wrong or a signal can interrupt the wait for the inode
> lock. ovl_open() simply fails in that case and
> ovl_maybe_lookup_lowerdata() already warns ratelimited about failed
> lookups. So return the overlayfs dentry without warning. That's what the
> WARN() path returned anyway.
>
> Fixes: 42dd69ae1af4 ("ovl: implement lazy lookup of lowerdata in data-onl=
y layers")
> Fixes: 184996e92e86 ("ovl: Validate verity xattr when resolving lowerdata=
")

Nit: 42dd69ae1af4 came first and opened the possibility of goto bug
and then 184996e92e86 came later and depends on 42dd69ae1af4.
I don't really see the benefit from stable POV to name the later as Fixes

> Cc: stable@vger.kernel.org # v6.5+
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-214581@kernel.org
> Reported-by: Chris Down <chris@chrisdown.name>
> Closes: https://lore.kernel.org/all/20261114120557.4bc1eb6e57218cdc@chris=
down.name
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/super.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 08695a99f4f93..1985b553a47b7 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -58,15 +58,13 @@ static struct dentry *ovl_d_real(struct dentry *dentr=
y, enum d_real_type type)
>
>         /*
>          * Best effort lazy lookup of lowerdata for D_REAL_DATA case to r=
eturn
> -        * the real lowerdata dentry.  The only current caller of d_real(=
) with
> -        * D_REAL_DATA is d_real_inode() from trace_uprobe and this calle=
r is
> -        * likely going to be followed reading from the file, before plac=
ing
> -        * uprobes on offset within the file, so lowerdata should be avai=
lable
> -        * when setting the uprobe.
> +        * the real lowerdata dentry. Callers may ask for files that were=
 never
> +        * opened, e.g. for uprobes or O_PATH files, so the lookup can fa=
il
> +        * here. Return the overlayfs dentry then.
>          */
>         err =3D ovl_verify_lowerdata(dentry);
>         if (err)
> -               goto bug;
> +               return dentry;
>         lower =3D ovl_dentry_lowerdata(dentry);
>         if (!lower)
>                 goto bug;
>
> --
> 2.53.0
>
