Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84195A118
	for <linux-security-module@vger.kernel.org>; Wed,  7 Feb 2024 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316008; cv=none; b=GMIr3xhjJJRycKMwrhwtZdID4DSDTjZeHNVtqUwzHBdVQrJvzmH5cuGDBjaen0L5TtVWY8bJJ2WFm4mJY7QjlQ3Rj97aG0bh63tKG7hMpNYJ0E5WfqY3dCFpVSQnYGoz2zXF1DmCWEZ8m3lDEvR/+aKECMeiLTLSj+UTWuLmCfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316008; c=relaxed/simple;
	bh=SzNba8tns2PjOCy+3sLZurxF77k6eo+WRElh5iR4ztI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qf6lASgtP785hyjoDxkwRXF1J0ZKOej3Tf2C3fwOKsobWyE35V/CJ8hHRT6IrJGIrqybc8W1wRdgxzNXgWyraBkuruxIwMHy9SsNvCvfzVCHiZzdhBlEZXkppQZ9lCQHF6frMd9B5Nr7Uo0jSftOVv7vNSgA7m1DPUCK22X4P8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IeGPdI4T; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IeGPdI4T"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e14b858785so366347a34.0
        for <linux-security-module@vger.kernel.org>; Wed, 07 Feb 2024 06:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707316006; x=1707920806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b35sBEtbFqh3Pg3VieC4+YWlOps4TFS92ag8IjVB+58=;
        b=IeGPdI4TFeAM4ulxEkU2gHnhbbQ8pGMCY83nA4Fvy8kjJUVTAIFOB77bWFuYks4XO1
         Sv2S6PhKyJoifHCQUjHM8z2RYOOP3lt/wdeTDABY4xa2Blk08pu/94I5mCl9V/WiA8rT
         FS58FahLkIwP+3AuhYGXsHmuwNTIVVPB1hbWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707316006; x=1707920806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b35sBEtbFqh3Pg3VieC4+YWlOps4TFS92ag8IjVB+58=;
        b=W4PB6qjBtv/+zIvFc8qkhmMbmmXSJPLr4o/OmjuIqQG3BWzNuPIxE9HKcfK2eJR/u6
         LvbDSLljmHqtPBVMI3Qdw3PYFVJhMCfakZEhCPGoIynhU2xbYTwmRkYqyNSkSzCjhznL
         4++vkN3XcfdbSSSLREdkehMNMQ5Hd3HYMot5Upv8CiRmK1rD7+BsbiUowpSiuIH7PEop
         839yrHaaB+0EoI0HPS7JsZw09d19IHO6qE3thWajtQOTg1EuY3z1zPTLHl3/6OuEllKi
         btJXKJSAR5PAmTGJ1PqTaOmo3xkEBim87Yhpiei0jtwFO9z6WNgwZjoo8igGdlEv2zmS
         k6ng==
X-Forwarded-Encrypted: i=1; AJvYcCV72FwwBQWpcRaCnNMOcOWHEDEEzzdfs7tGNDg5BLnMZhA4NldLPxmXAcKcN5HxnehcjeIJAXtMSQBaR+mxRRFyKmZRd8hzav8QqQxX2JRmucD/IlN7
X-Gm-Message-State: AOJu0YxQe69Cn0r8/Dysi109bPL53mQM/qJDhEti2oPlEkbEj3QJJmMJ
	0kp38z5+YuFA2a1qvOJGHMwMIMTse8sJTmT+gB5CDds3KyAN7H+v7XoDCf060Q==
X-Google-Smtp-Source: AGHT+IEDOylu231KDIh4sMA3cVAttvp/AJwj9dEU0mykM819lTgyMUQoFPhnukQ5YsRpK9sDmH7kfA==
X-Received: by 2002:a9d:6b1a:0:b0:6dd:e95f:c6f5 with SMTP id g26-20020a9d6b1a000000b006dde95fc6f5mr5343343otp.37.1707316005810;
        Wed, 07 Feb 2024 06:26:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXGaj4tDR3W6GsuU3ECICUkCbx7bJKhuRe0NK/6JLYesRSbPGzMki3W55ANLUNjbvrac72TncJNOFcFyxhY5rqkQOqOmFajh3nJ/NBiHUKABXgQEYGj/cQhTUF3sTOC9CobPXIaDkuuT0XlUN+uqy6itwZ9NhhKdaC2Gx4Zmu7OPZlhkGBgLSigoppQ5sXWiaubs1ryxuIhVxSP3SGzYFpoj5/FO8LwPJ2MlwMVeR121h12q9xZusZ13My+Bp9Ya+lydQs6FoHKzyenMw1kpRIlJcqejx0fbbQwb0OYhPsedVnlNdXIqidxnSQAe3VU2ARyuovlR8nHSmO1UtvGLIz35ZxzbnnjnRlUodi7ppxgTPBqO4XmzCor85xaKLN
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g24-20020a633758000000b005d68962e1a7sm1563691pgn.24.2024.02.07.06.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:26:45 -0800 (PST)
Date: Wed, 7 Feb 2024 06:26:44 -0800
From: Kees Cook <keescook@chromium.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] fs/exec: remove current->in_execve flag
Message-ID: <202402070626.C4B0476A1@keescook>
References: <8fafb8e1-b6be-4d08-945f-b464e3a396c8@I-love.SAKURA.ne.jp>
 <c62a36de-716e-439d-80a2-57e6a3c22db0@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c62a36de-716e-439d-80a2-57e6a3c22db0@I-love.SAKURA.ne.jp>

On Sat, Feb 03, 2024 at 07:53:39PM +0900, Tetsuo Handa wrote:
> Addition of security_execve_abort() hook made it possible to remove
> this flag.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Yay removal! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
