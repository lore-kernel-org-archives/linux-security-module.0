Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C142571BD
	for <linux-security-module@vger.kernel.org>; Wed,  2 Jul 2025 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751453284; cv=none; b=qCznBduGKT48VVSQapwyzIgKChKV3sOQVkDcwf8azp+inq0nH5cyY0HyYUbHOlQFsF1d/k0wrwbbuqy71wcEFldO+DdxG3NtvDUEwLduNMkWgLGC9J036AWbD8qv8fxOu8t9QSnQqABdaGXINjfM2Y2I1OpsFNde384DRELochU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751453284; c=relaxed/simple;
	bh=x0AFjkDlvAQocIajLTiEtOk7pDjdbIyb5Vl8YoFPFC8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q0rRDINP99NjQOjqEMEJ8/F+wbviKnCZWrEBEDaY57ZsbEuZs8woG0WAVYzkaL4oeOx4Es4ffa9SnwkWCf0LkXAxvWZvP13GKEs790hN8y+GVNkfhJEmX/AETu1x30+Haqdkcnb7+GSPKw6iMZComUbylMdadvHakeniRoQgiv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VpDcCa9s; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VpDcCa9s"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45363645a8eso46280305e9.1
        for <linux-security-module@vger.kernel.org>; Wed, 02 Jul 2025 03:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751453280; x=1752058080; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZaqLaJib84m+unN67Qm6MiaO9gj1dwxDqxkPHoKHM38=;
        b=VpDcCa9smd/NR8ALKfvOcaR+JRJyPiTN1XWd7ed1bal/ZCgDN5rOUi1ONMr7O792h3
         MYq5MoHmfGGRDa22ksaY6CxDQ9cyWL7ECvzjUt6kVa0Rkjje3sCFlTgVdh3tQ67tCnAu
         wxnjGwBgLkSXEx8ZboMiH0kHW6tFYlERP90oyb4+h7EKFgxE06WkG7ReMFt+P0YSWsnl
         r0qDxw9hKNGfpApVS9pQYKfx98MZ0EdzJuURrGvEfNJf0BvomHi9zYDay1AwReZU7JjB
         5O+fyB0Ty8rLaEzz3KBMmxN3gKEOI/ZMke8WnkdNTjSRXIWJL+NG3V0mE+jJrfA/avVV
         UrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751453280; x=1752058080;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZaqLaJib84m+unN67Qm6MiaO9gj1dwxDqxkPHoKHM38=;
        b=mpaM7ZgUKZHtGbnavSztJ/fJAzmlHrolkCXkB70+BGEIR/MFfs38ix2PZJr7vxlUIa
         0uGptl1DgnEbKxcvcUXf0a819gqAOvF2cGEr5Y4QeLV9v//09SG9Te6CYzx8kbUOtpqH
         Z042YwHQAv60f2rA3YwIT67iP98UlUmQWFIC9mGlCM7ELmHz8UHKLBfOUYC5AP3z91Z8
         XCpRhCBi6erhe/o7mYYl43UsGaDig4ssrG27VjWeU6TZMuhAjdtgapimjvn5h4xfCRHM
         qaLDjsJt8qvj3kdcjf0Irt/Bj1Twne4rQXl8IkfAFiXJIOkkN9+umpd+e4jdFAxPBzRX
         i+gw==
X-Forwarded-Encrypted: i=1; AJvYcCUwmcAmRws+rJNTzS9X4HSArvhUcHonuz2H2P/O+3nuuRyLdDcxjeKkA7NiUv7++jJIKOG4+Fpjgp/bMFXps1WVN8irUig=@vger.kernel.org
X-Gm-Message-State: AOJu0YzToX11l/fwBsfmCJeyNDNDrMYg0cu9nmCI0mJoqjGLB9kLvAF3
	9wBVnKG27K7kAlwhxnYkOEfkLywNVAmuRZS8OLLh5F3NOQqL1pALT4hMvN/oD/Z8yVw=
X-Gm-Gg: ASbGncu+k+VJsY1GJqVc9NcsqfOCBHYzvXM+rLwwMkO+dpvIox/GDimGTtZhS+syh+J
	koECYpGMn771/f03p3kjyU68Tkz5dmE0IcKWNDk7rc0FmT/AUDlWHTwohVhD+Qpr7zdfJ6YLS5h
	yufvnn0nP+cqTsmYeJ64aP420JxVw2C+6ztv/tOYAlI6CG6WlFMZTT8rLx07RQ7VYmEYdDTDT/2
	NNEQ2j89PKMETT20hOOIp+jsWCYJocU1ebRrqPn91ONqhfdVBrnbdIi7oVBSjJ+I+1ecOITnGzM
	tvk80IaVDbtlqQBsydPGurPoX6r3A2yZDhXuWK9O0ElvEX4XDHjuMAmdIf4TWPt1QcNgAJutWbu
	2
X-Google-Smtp-Source: AGHT+IFDoHf+aaq4UzigGUWl+x39S/WR6MN+OvN18dQGCVdn/JrZS6PzX26KE9GWmWHItZgUMtOHpw==
X-Received: by 2002:a05:6000:4718:b0:391:3aaf:1d5f with SMTP id ffacd0b85a97d-3b200e2a0e3mr1859101f8f.52.1751453280453;
        Wed, 02 Jul 2025 03:48:00 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f8a0sm15970228f8f.96.2025.07.02.03.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:47:59 -0700 (PDT)
Message-ID: <78b13bcdae82ade95e88f315682966051f461dde.camel@linaro.org>
Subject: Re: [PATCH v3 bpf-next 1/4] kernfs: remove iattr_mutex
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Cc: kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com,
 ast@kernel.org, 	daniel@iogearbox.net, martin.lau@linux.dev,
 viro@zeniv.linux.org.uk, 	brauner@kernel.org, jack@suse.cz,
 kpsingh@kernel.org, mattbobrowski@google.com, 	amir73il@gmail.com,
 gregkh@linuxfoundation.org, tj@kernel.org, 	daan.j.demeyer@gmail.com, Will
 McVicker <willmcvicker@google.com>, Peter Griffin	
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	kernel-team@android.com
Date: Wed, 02 Jul 2025 11:47:58 +0100
In-Reply-To: <20250623063854.1896364-2-song@kernel.org>
References: <20250623063854.1896364-1-song@kernel.org>
	 <20250623063854.1896364-2-song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+build1 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Sun, 2025-06-22 at 23:38 -0700, Song Liu wrote:
> From: Christian Brauner <brauner@kernel.org>
>=20
> All allocations of struct kernfs_iattrs are serialized through a global
> mutex. Simply do a racy allocation and let the first one win. I bet most
> callers are under inode->i_rwsem anyway and it wouldn't be needed but
> let's not require that.
>=20
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Song Liu <song@kernel.org>

On next-20250701, ls -lA gives errors on /sys:

$ ls -lA /sys/
ls: /sys/: No data available
ls: /sys/kernel: No data available
ls: /sys/power: No data available
ls: /sys/class: No data available
ls: /sys/devices: No data available
ls: /sys/dev: No data available
ls: /sys/hypervisor: No data available
ls: /sys/fs: No data available
ls: /sys/bus: No data available
ls: /sys/firmware: No data available
ls: /sys/block: No data available
ls: /sys/module: No data available
total 0
drwxr-xr-x   2 root root 0 Jan  1  1970 block
drwxr-xr-x  52 root root 0 Jan  1  1970 bus
drwxr-xr-x  88 root root 0 Jan  1  1970 class
drwxr-xr-x   4 root root 0 Jan  1  1970 dev
drwxr-xr-x  11 root root 0 Jan  1  1970 devices
drwxr-xr-x   3 root root 0 Jan  1  1970 firmware
drwxr-xr-x  10 root root 0 Jan  1  1970 fs
drwxr-xr-x   2 root root 0 Jul  2 09:43 hypervisor
drwxr-xr-x  14 root root 0 Jan  1  1970 kernel
drwxr-xr-x 251 root root 0 Jan  1  1970 module
drwxr-xr-x   3 root root 0 Jul  2 09:43 power


and my bisect is pointing to this commit. Simply reverting it also fixes
the errors.


Do you have any suggestions?


Cheers,
Andre'
