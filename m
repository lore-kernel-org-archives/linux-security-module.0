Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08CF497B61
	for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 22:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164569; cv=none; b=tgotVO7KisKZb20Z29NKO7A5Gxrpo2jAdimqTAQ7U2OcQ+M5/0xv2kspkR0KRSAolNeNAQO2qXZ7as+UnHBRlg3b3T8fxfmd2gGwBj/DclVZ2hT5LOFVS8dYYHmHy19r0BDOhhxoVizI0oPAFcr8wm/tZgKXnDr3i0aABezmEBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164569; c=relaxed/simple;
	bh=ZhtceR9Fm3x1PqtxgXKQP5KqcUOG2uEBhA+0sw07vNs=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=fKg63pTKKApxqB5BupqJAbWyGxemSgmA8BKt7CS3E3zHlKogOVVC7hh28bD2hypuaFOW+qoASPEQOvf5Izn4U9kp0euq0GBqhY8IJ9tIlwP6qtl60ZUq+ttZE1tMU+AxnGEg8zsVnOs7I6/WjnW/YTImGPg3HQpq8hk/f3GjKbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VnmBmrqF; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VnmBmrqF"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfcb5cb1so634756d6.1
        for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 15:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789164566; x=1789769366; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3LX6vyJd3+fW0hcCFrd1cZ1+qMqiip6Fji47Ec3/FuU=;
        b=VnmBmrqFi/Ky4EaYgXb+5LF0He76SwsE1aEDzuw0ykfftpg/LAxW2KEzCLmMPDnhF9
         1Cga+bQIN5BIarqclsaDYRQJXkZH4tPexBGQtTIbLBUu1U1kzWLPuonSua40v/x8XJ8G
         zybm2yraGgkgfkCWl/11yEGDVANZ+Y7GjlfXG8B766jHmjSzgY0KaLGKT5eS12km51YG
         SqEFx1EoMOP3UxUDhU/agcvYq6gMqwHRRk4B1HTodUm24ZtE/CzECRRhCIhbnCAMytAW
         Uf/guP7ZX8TQn9qmrJCebZPtYBlPkbwRL4BIvMsmgEQuTfez9+j+UaCtUZnJ3cahA9LO
         PJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164566; x=1789769366;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3LX6vyJd3+fW0hcCFrd1cZ1+qMqiip6Fji47Ec3/FuU=;
        b=Dzjz7zg2gnkLVBDXhNxIJZkyGNAO8+Ohxtv8Yy+PQLuSVS8aJj1oZ8gYnyVHwmotJJ
         SRwqAx7eeUxG33BlOclcEzZ5qG4SIqoScj8LwXxRxaLEZZfANYNz+O6XD29q24xwIzqN
         mGoo4aFW+ysJi+s5ujGdKSNB7OL9JI6nEV+PyNgdGglMaQt2NWkMHMqEUC2Ct0HaMzf0
         XIry081s3piZ7K0GZHA7fnD6w5VBzfyokZ8MF/KysLNTrzglwwOVjb766B+gEcQP9nSb
         AY1pb1fbVUQf3JKFZGAgqtOfxfftXroMzb5rT1/fd5bXtEy79qiXYa2v9IAYxbOaxJtj
         0zCw==
X-Forwarded-Encrypted: i=1; AKwUvBz6sTweDoqiixVzyx+Y+rLv06lWnZ3furnbgI7RCE3GIV9Irhpu0fF2e5gwH78p0FADZFT+sEKR56DwUltfHbL+GRJD5IQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kB/OK244MomZJ641STJb2YUqX8yLHpx6H78+XdsD1LONSdCl4f
	aqf46XyP8m4fTtDfpToYGTEdSqPDxhbWTw8EXsj11fiW4HzpuVPfGo0v4QCsPcWvAYl2QFWtH8C
	tPOkbDA==
X-Gm-Gg: AYBFou2MTZPULgluOwf7l4j3MVjv+BR/yMwplC04p3jVl5hZkUkZKFFW5e3GGR6QlD0
	Q8pvbRGvLk3Oh54XEtRSOP687ZPPPBYns4udvgdbal38vJSHOI8/hFGoCrhL9+iNP3IPn0XZFwL
	imzH12mpg7KYFfTRtfoSdZglxx9R3yDIw67BlE24pErMB/6EFc4uUPUBewVG0pvuGrNLJIPkagO
	svDmikxKfX+J45bH9eve+6miq1mxm5MzxQfbx4Fa2eO1Eqx4VOogQnfK3bcswYK5qKNhUn7XXSq
	G+mcaGyYoCATQoXFbyXMRQkBBK78F0tz6vxu4lT+qfhz4Y/npBi97qp+EDhDKQ9Yd4JN5LDnflY
	XlhAgo0PJgNjMkYhzRRGeWBls8f241f1yzeAo80EgVTTqZy/9Vm27qf1iDOQ/67U+jV2c4C3zx2
	5JhMj7vawIss3PradKLiowOUJb1rvvwFr1UalB0JLC6uABZYp6zkIbKFgR9ohOH5JSUB8gd7kxk
	Ik/yUJ32uOHrRXWhkm7lXiORzwhUbj45Gv4aX48DLZW+torgjYHU1l2T7SeSpv8MPb7GwzG7lk1
X-Received: by 2002:a05:620a:260f:b0:939:3a81:326 with SMTP id af79cd13be357-93a0390793emr45756085a.37.1789164566557;
        Fri, 11 Sep 2026 15:09:26 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80bfc90sm342667285a.37.2026.09.11.15.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:09:25 -0700 (PDT)
Date: Fri, 11 Sep 2026 18:09:25 -0400
Message-ID: <81cbd4589373304334c7df4c1eba3660@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260911_1254/pstg-lib:20260910_1848/pstg-pwork:20260911_1254
From: Paul Moore <paul@paul-moore.com>
To: Lincoln Wallace <locnnil0@gmail.com>, corbet@lwn.net
Cc: skhan@linuxfoundation.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp, rdunlap@infradead.org, Lincoln Wallace <locnnil0@gmail.com>
Subject: Re: [PATCH 1/2] doc: LSM: describe CONFIG_LSM and lsm= as the  selection mechanism
References: <20260714013832.977443-2-locnnil0@gmail.com>
In-Reply-To: <20260714013832.977443-2-locnnil0@gmail.com>

On Jul 13, 2026 Lincoln Wallace <locnnil0@gmail.com> wrote:
> 
> The LSM usage document states that security modules are selectable at
> build time via CONFIG_DEFAULT_SECURITY and can be overridden at boot
> time via the "security=..." kernel command line argument.
> 
> CONFIG_DEFAULT_SECURITY no longer exists: LSMs are enabled via
> CONFIG_LSM, an ordered list of the LSMs to initialize, which can be
> overridden at boot time with the "lsm=" parameter. The "security="
> parameter remains as a deprecated way to choose a legacy "major"
> security module, and is ignored when "lsm=" is specified; see commit
> 89a9684ea158 ("LSM: Ignore "security=" when "lsm=" is specified").
> 
> A previous attempt replaced "security=" with "lsm=" in place [1],
> which was rejected because the parameters are not equivalent:
> "security=" selects a single major module while the built-in
> CONFIG_LSM list otherwise remains active, whereas "lsm=" must list
> every LSM to enable.
> 
> Update the paragraph to describe CONFIG_LSM and "lsm=" as the current
> selection mechanism, keeping "security=" documented as the deprecated
> legacy option, matching the wording in kernel-parameters.txt.
> 
> Link: https://lore.kernel.org/r/20250114225156.10458-1-rdunlap@infradead.org [1]
> 
> Signed-off-by: Lincoln Wallace <locnnil0@gmail.com>
> ---
>  Documentation/admin-guide/LSM/index.rst | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Merged into lsm/dev, thanks!

--
paul-moore.com
