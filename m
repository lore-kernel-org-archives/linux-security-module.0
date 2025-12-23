Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A887258EDE
	for <linux-security-module@vger.kernel.org>; Tue, 23 Dec 2025 21:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766525345; cv=none; b=eMNWl6wLaRKRTU6hiC5auII5/gza1dCD8nmp8Uo6K6JApxGjQqtdZmvFLoTMJsvhwECHKZbGq4AKsP1Dt/ZXEktJyDFLlVFZOQ42/9MIM0gW+TKo8Jj8Rinx9Loh3/BMKk+ggNX20bYNWJ3LTKDV4QHkPT4QxmvQG4hOfB0RDI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766525345; c=relaxed/simple;
	bh=JPO4vrc+nhREdXMdVJjjOOYRkFVKGcRDnNxKdJnIxa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3hfWoQ05rFB9B4n4h94y5DDnqOaVMIT0SH/jhKX7gVW8h+wUlkq89a0PpHTpqKhWZFeRL33TLfyBShhgihB4sMr4YNtevEAHnKfmvY/3GhzF4w3Br74KyzZW73Dp6L1gzhLpYMX5QEDxm+rHQqWWRDeOb1e4ChdcEE8apd8MuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKlnseh0; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKlnseh0"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b735e278fa1so936842766b.0
        for <linux-security-module@vger.kernel.org>; Tue, 23 Dec 2025 13:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766525342; x=1767130142; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=651T3B3wGmQ+7II9Y2q2FrKYHZGWZWuLDyoMa2douVQ=;
        b=CKlnseh0RlkBNHG2YQrF7q1VM1uZTBlYQEzgs8GuyO/LOuhI+CDVgb+zCtoRz2RlyL
         cYQo7CU6umcSBtBCszbKgGlKOvzOFq3/JNXmlG7FzP3XpK+r8MsysTXOiDUOICHcCyD6
         Dp8uZy4B1fgC0fLVi2yEQGwPgBRKiJV2NOqUBzcHrdTMUQOJbrGvz2oT2dpcSKfpulOQ
         M8PqlfS5izHEtWTWvKMiCdiXkOC9jaYpFbZrG/WlmBDtFZ88EyOwXwOSNPb2tXfeh0Ov
         Oa35VOr6hu/StHt/OqqHjruqQ5+x5TE+u9kxDNtxQQcMGTY5S2m+2yLlez0wPCmvr1kW
         HWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766525342; x=1767130142;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=651T3B3wGmQ+7II9Y2q2FrKYHZGWZWuLDyoMa2douVQ=;
        b=QcMm3bP8K8Zj6QLH16yVdX0RXkFQhL1e64sIwwfIw5cRQWsl7wzkmnKFP9yCYbOVDt
         oGRKuds6jbt2txA3JDL75BvnkfW8GYz4cP99yQedYMs55tlrmjSql+hvY2fBlN2jbTWr
         +F1M74OZ0JlzAODF4ia5mcQ5VIKAyu8mCAZxs9oQVIUMH2A4WcU0IEhmgTvL6tDOY1Wy
         hD4gXptGpXLtYrp1bqi8BNLG7tf3lbiSDfMpocfWdkR6lLHAp1+7rf6Eo3QVpAtLulgh
         CQa3OhKy/Ycuj1tsTrciSGIcYExpTTyQwtGvJc8Y8UKVhDDHOhIKr50+FybYnn9tfuiE
         rBeQ==
X-Gm-Message-State: AOJu0Yyb7QRkbBRRrIXhUmFELLFGmRZtEP0CkkJ/IYZH74xFVSlR3++J
	jeQ8CRcEYShtcI7ypWQqqEvCaqZPP4Ad9Ox7AQ4Xcyf6bB89thFsi2YPoB5f4Q==
X-Gm-Gg: AY/fxX62x/OOqVtaL1uideioqEf5E4fRft1wzxuSw+yc7cDslKtfwrSs0YcOhotM891
	w/qj0hMgnCsARkvw3FSUykuNnk0qovbM9M9vXA0oOy1o0h33xhrOtUqjjlCJ/vlXjKTUGpL95m6
	NbiUnWueRZHyoKikGIPKpxdKW0s0V8C5dhSaDmsgBODl3fsfrFjfoGjvi5snzRtHDUxTaQFtG7g
	BqeRPy88Y21OVai0NZjrPQQjJ91Ip99T/RaCochFsrdoYQcTeWr3l1DC977WVh/jx4m4aUZQXnc
	nC0leCvLG0/rs621O0BmzhU5NHTMgTaP0XujqqKXOE+Tum4Xy5rZWSHP3tRuXiN+7+MVItFqyeQ
	L2zjU8mBTi48D7Whp/olgWLfBL5EyRou353FPnny+id6ym+QfD+b1sZzdnuoCYqtQDqMSdrHA5Z
	7ynS6Z4qS4bTNNfVhQLitysjndl9jPa99n3mFSK0/uvhb2v5w=
X-Google-Smtp-Source: AGHT+IE7B6RZCFfrpK8M1FZnoAgKCzUKrn53fpcEiQ7LPt2x5BCIXVox6wDhc0N6FXWyE2SEXEjnoA==
X-Received: by 2002:a17:907:6e8d:b0:b7a:1be1:823 with SMTP id a640c23a62f3a-b80371f4980mr1582212766b.64.1766525342388;
        Tue, 23 Dec 2025 13:29:02 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f089fesm1521958666b.46.2025.12.23.13.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 13:29:02 -0800 (PST)
Date: Tue, 23 Dec 2025 22:29:00 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 3/5] landlock: Clean up hook_ptrace_access_check()
Message-ID: <20251223.ae0331d74dce@gnoack.org>
References: <20251219193855.825889-1-mic@digikod.net>
 <20251219193855.825889-3-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251219193855.825889-3-mic@digikod.net>

On Fri, Dec 19, 2025 at 08:38:49PM +0100, Mickaël Salaün wrote:
> Make variable's scope minimal in hook_ptrace_access_check().
> 
> Cc: Günther Noack <gnoack3000@gmail.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

Reviewed-by: Günther Noack <gnoack3000@gmail.com>
