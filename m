Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0B226AA98
	for <linux-security-module@vger.kernel.org>; Tue, 24 Jun 2025 23:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750808676; cv=none; b=NcPrIxyudRPO0MUTLs2gnGvPzCfJuqlBAf6qUezpVRaFk0KHt9t12GH6KoHIdJIrVF5CaudMTmMqoTcqUpVzH3wMh91xpvXJF8Eh95Ko96BeNIpETt7RlpgJA9HWazkPID8Sy5NiOJ+rD+/pe/PZduTTui7GzBnj/pJrXF7/yUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750808676; c=relaxed/simple;
	bh=phaDN7eV8f6TzylrwNnPTs5X3yC1ERVNmiyd0BZDIls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=og+kCcw+EgbQ6TkHCJIk8yLPqSUvwUbf8cMtGbAe1bSva3MPlAGJOZ+pW2QPoVfDy+GcHa3sjjamn1Ophj7O3LGn7q160wWZFdF5aS3++3BroU/o/yjPAX/pg/vdaAiR3M2HMtbl1b+YYBuNgo6xmXK6lWAWkQInqeAqK/stwfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OvPSwlip; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OvPSwlip"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70a57a8ffc3so11878937b3.0
        for <linux-security-module@vger.kernel.org>; Tue, 24 Jun 2025 16:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750808674; x=1751413474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypGqRXT9B6uz9VhXeJhe2F5sbavYCtgIItdaOAEXkS4=;
        b=OvPSwlip4Kazt/S9ri2j5VeDhKda3I8b1Q9PV6y68MNtHjhVuPC5elfuYB9bigs5tO
         w+nA6MHplF++ChPYTyd5lhDGickosH0q7WTpJdbfAH36b4jWbY1PaO/47pnIhnj3nvXt
         WK8upkmDTdi41+Lxu4KGwmDsn8oVgXum2GQJ1+EQHlk2Kn++fV9YmmpED0OdnRGA9buF
         JRurl5/iI5DdCi6xxf7+WFBbOGojJP9yxyeLEf8H8Njt0hi1es4pbsPNZx/tVZvFHV1R
         EjIGqPCIIO/ijxKP6QgRpKDlZdcqL9Nu0fmVuIqcgbCBpTcTyvyYmwwjB8Q2b96ZRxsg
         rfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750808674; x=1751413474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypGqRXT9B6uz9VhXeJhe2F5sbavYCtgIItdaOAEXkS4=;
        b=CpJuu0i/8ZLgEr7aeXIeagaNorOfXmm7P+5ntF/GZYeN4AdWxjeFduKRmE63OvNraJ
         kaGgmibyDX8lWIlNs+rxOUc7ZYn+gT7CS1adxFImzLil6MbzWHDYeV/WXolqL42GNgaw
         20rseNWjuhifPKhHxcpexKp3WM3hPqRkJ1GzNCcN4jbCHhCS6e/loZYxVVd8ezeW02Qf
         IhY3nw/y3ZAIWCj1vl9VWGnRiUtdCbUyLCnuUDyNnOJk8LDEQGmxnnEGSlt3SfdB2EKg
         16ILyBy0BzTpB07wpk1ubJJzm6GCcYee7bPk5ldOfq080YdfKGwsAIkU6Bd1O29QAK6J
         LClQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjb4lfCOHf3GczcLnHXS0z/BPnIByGYi/N0vVMCC+1JHalvcw3cEh1aDXX6q2THiPf4n4hl0brFS1B4r6Bu7cD1EIe1i4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAruuSx7nBu2hy2g1B44vWsWwVnZ60oQGh+dhY2mLiFTTKRv2D
	RYKh9o0v2fwoIA7lA/xhJbNitwrmyJfYeJL7vf5KYe6U/qjACvjDMwjK51b7Ewy/rtedEzYxKXE
	3D+ORBOVPFSoGKra3FVHbX0j2WjEzPFD5nnmrwJKK
X-Gm-Gg: ASbGnctH0v5HjZ1AyqA3tMy3KDtduBuKQ2WuT7AJhSib+A1Z6IHmi/GP4QC7YKl604D
	0R817e8dIMrgAjvfpGplvfepb/tGN9R2UHFasTLblX4POLAvy6AU7QRGzG17B2qk/SN5U58stJS
	efd4e7SLDHPLu44KxUaz9ByH5hvzdXxx+hAR+1mx2SpaU=
X-Google-Smtp-Source: AGHT+IHYYzpIRcCARvY/5Tfe83HpMMGfatz5XhMVHQG4Ncv8Gwm83fUH9i11USV7knuqyOID1THO3kDuJPt0AFVqMkg=
X-Received: by 2002:a05:690c:7011:b0:70c:a854:8384 with SMTP id
 00721157ae682-71406cb4bc7mr15901777b3.11.1750808674451; Tue, 24 Jun 2025
 16:44:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615003011.GD1880847@ZenIV> <20250615003110.GA3011112@ZenIV> <20250615020154.GE1880847@ZenIV>
In-Reply-To: <20250615020154.GE1880847@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 24 Jun 2025 19:44:23 -0400
X-Gm-Features: Ac12FXwcVhx-YeOi1FT2F4B7uxfo2lfTBSXihnFcoA7yu_J3MLk0q4urxj_iGGE
Message-ID: <CAHC9VhR6BAOqHuBf+DdWQC-D+Lfd2C9WLTEpFjy1XQkqH1syig@mail.gmail.com>
Subject: Re: [PATCH] selinuxfs_fill_super(): don't bother with
 selinuxfs_info_free() on failures
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 10:02=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> [don't really care which tree that goes through; right now it's
> in viro/vfs.git #work.misc, but if somebody prefers to grab it
> through a different tree, just say so]
>
> Failures in there will be followed by sel_kill_sb(), which will call
> selinuxfs_info_free() anyway.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  security/selinux/selinuxfs.c | 2 --
>  1 file changed, 2 deletions(-)

Thanks Al.  I went ahead and merged this into the selinux/dev branch
to help avoid any merge issues, but if you've changed your mind and
feel strongly about taking it via your tree let me know.

--=20
paul-moore.com
