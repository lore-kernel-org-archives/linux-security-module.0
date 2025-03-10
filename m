Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108CE2AD16
	for <linux-security-module@vger.kernel.org>; Mon, 10 Mar 2025 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636727; cv=none; b=HR+lOHV6pcdJtL9xvwsznPETBCrENPBAljOPtfLE58xJk/mB+0Lh70dgSkzMSv8HYEIJeKH5XbcnBthmIg8hpcVwTr1YYXIMfJSLCtfIH/NgnamDl9Vk/LXlBPgyiSKhB+c9MzDcQT0LorZybXjayHQZ0l+QEx6oXOHn0DBjQp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636727; c=relaxed/simple;
	bh=BkkDL48kiKo+5qqGRWHrngtLxhgjyU+pX8OARxDkQNk=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=Lvu0Irou0xqMTjvOlwBcVOvwpMXn+1TsvrZE+ZZVk3G+zVAdxrsY1wrpV2zrVboSMtgBy5r5glUqXS/izcBIOt3La6VuLgTwENSJN7uVXrNDhsyR0k17fzaZfnI+oBRltUgqd2UqQQl1jypUMuBgxMRsLFVzbv6VhbJr6rJjx7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=T9es5BKE; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="T9es5BKE"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47519994f25so65154811cf.1
        for <linux-security-module@vger.kernel.org>; Mon, 10 Mar 2025 12:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741636723; x=1742241523; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6wuWmMKRARxB1Eg/CdF6hbh9IpfkyXmqRnG/h85u4Y=;
        b=T9es5BKEwpymJXt5h6/MNJNkEvScBzF2XwT8QpAEAkNcvv3FeaWrPM1gb+qxwbQLyy
         UKQQOWGBh7DKJqpBTJub3PtPNO9OVdUgCKH/YSJBAlPpRjqs+Z1IJwWg8JlY2SHvNQ/y
         ZhzeohIlFa6cwDRIyG2qoyufQAOwWly92M1AvF+neRvnOK20ApKharzMvhGi20RAf3mV
         rl1r/cRLHmfoL/utC8z/1hIElhMb3Fb7ddwVFpsJjgSVqPRxx15uovHswKw9dXYOP6WF
         lL46bgKU0aKrY25Pj1Bjyo68cx2UZ55tC4gsRpjtrtfFJzxmlxxLqQkYYmHyUHEbenPL
         BEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741636723; x=1742241523;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i6wuWmMKRARxB1Eg/CdF6hbh9IpfkyXmqRnG/h85u4Y=;
        b=LpicXuyxIVCxNPomynoUUR3yn+OGSp/2+3UB5e0zZufmFxjDYV9zO6gOoDNGy5MuBR
         gMZW/A3JfM8gkA66UGglNjjB1OzwtxyEgx2Yr310oEGki6kSGa0DU4gh/7edh0K/UZII
         YAp34gKqrUjE2VuXxNqOwrOBBoKCjG3dkaRzu5y86l1A4JnKUxHCK7yJmlIUrhi81V73
         5apZ/rTEArVqOPieZkxvI3x2iMxkqqWqmEE+2MIladmHFYOqhFu3tiIxqkGFgyAJ+1oK
         iCHq81kYBi/qgJ8K33VSqhFhQac6gEtFzkdC0E5lKMy6OUKNvUlGj2VTfz3KMVBcuGxY
         ldVA==
X-Forwarded-Encrypted: i=1; AJvYcCW5arT8AlkgL+l6MPlHPiJSbFPyfWc69JYX8W3RP1JyWD7dBHkB/fiAxjgviHZtbfEE2QYRTfq/5WwtS9VeROaT5VBR7ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQqpDu+aP/mf84mrtlrnO9BvHcdSUKv77nwOxygpPC+oJ2Pesr
	8I+iQiXpH1/5z3S/d+qZIhgFPMnOe6lY4vOK6k2x/RtSqzcIONelz9AOArdxHA==
X-Gm-Gg: ASbGncsAJnODRNYUz9FdTVrOq4+3+Vci0K4NZCYhTlb8IRaUGiwOALUPSUDmpo6sm+6
	UR9PyR4alaCC7HjKo+62HRXdLf/hsaGZi73QEzyA9o3e+fMF9ibaICShoL4hxpB9mM6temafnwz
	ShHRya2BYrZOxKDA9RuzDaiw4bG4XOV5yoCZeUXcG0H7S+DBZWEtHCYEtSB4fBxTztI2fc0rZcc
	FZ7EGialIlYzejsE0n8dqF0bT1QUYZ7MxEHeT0V55oYqRs4y3ZVyodSRkUc25CDABGmm5LW5SbH
	Eiyms2PpdgSCR693xyIiM50+iE9o7ad9fM/2opMnx9bnjNvz2vXGPE2JbYY6mHDW0LPAjjIkqUe
	T3///YH8rdtOeSg==
X-Google-Smtp-Source: AGHT+IE15sVjFBcy+dpjt3Puf1WtPde/5nHjna93sAeAuE8+auuzNiDYrxeI+gkgjLXTbTf8g4XQqA==
X-Received: by 2002:ac8:5d52:0:b0:476:7327:383d with SMTP id d75a77b69052e-47673274363mr105538361cf.9.1741636722791;
        Mon, 10 Mar 2025 12:58:42 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476772de5absm29514021cf.66.2025.03.10.12.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 12:58:42 -0700 (PDT)
Date: Mon, 10 Mar 2025 15:58:41 -0400
Message-ID: <f44bad6065bbf45c02dc7caf90ed0e7e@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250310_1216/pstg-lib:20250310_1216/pstg-pwork:20250310_1216
From: Paul Moore <paul@paul-moore.com>
To: sergeh@kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add Serge Hallyn as maintainer for creds
References: <Z82Sug-XLC1r5wKE@lei>
In-Reply-To: <Z82Sug-XLC1r5wKE@lei>

On Mar  9, 2025 sergeh@kernel.org wrote:
> 
> Also add the documentation file as suggested by Günther Noack.
> 
> Signed-off-by: Serge Hallyn <sergeh@kernel.org>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)

I adjusted the subject line to reflect that you chose the reviewer role,
but otherwise this looks good, merged into lsm/dev.  Thanks!

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 68e4656c15ea..54b47bfc4abd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6141,11 +6141,13 @@ F:	drivers/hid/hid-creative-sb0540.c
>  
>  CREDENTIALS
>  M:	Paul Moore <paul@paul-moore.com>
> +R:	Serge Hallyn <sergeh@kernel.org>
>  L:	linux-security-module@vger.kernel.org
>  S:	Supported
>  T:	git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
>  F:	include/linux/cred.h
>  F:	kernel/cred.c
> +F:	Documentation/security/credentials.rst
>  
>  INTEL CRPS COMMON REDUNDANT PSU DRIVER
>  M:	Ninad Palsule <ninad@linux.ibm.com>
> -- 
> 2.34.1

--
paul-moore.com
