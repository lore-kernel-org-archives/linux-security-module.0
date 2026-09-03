Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94DC511214
	for <linux-security-module@vger.kernel.org>; Thu,  3 Sep 2026 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788467063; cv=none; b=TeNzQEiFlyJWV+sR1JUM9X/3w+CHxfqTCQghttuo003CkRg/L9+iF4bkyrjWj94k0H2WUrLNQEJ1FZ3YJKZRpI3h8dNmdPyo2ooEwa+mpsufD1VSf5HEnHgXGxSdXzYOV8Q1m9/EGFZ9YAz7JmqY6b/WJJY/VhiMSEbzk8mXVOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788467063; c=relaxed/simple;
	bh=lovyBWo4HbHG9IAJc1682HSdnTeu5LyLU45uKHLvmeE=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=fv4fOTbwsZouTQbkP8bgMmIpCBx+Tej1ugAJe2lJdZBpMjtNAspc/ajLSG/jlYlpM4qb+7j8bC4xDr0C4UC9fNiF9YkitPLrIONdy39rsrSuKOIiSdYTOry0xkIxEXDRSEoTRxcevxCUEf0APPlTg+Dcq8iO1aVvtZOBiEjRWCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AdSsSsoN; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AdSsSsoN"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5303557a6dbso4142421cf.1
        for <linux-security-module@vger.kernel.org>; Thu, 03 Sep 2026 13:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788467045; x=1789071845; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B8uOzk5kbNElpXD3JZXWiXWL8uLf97nPgxHodv2izOs=;
        b=AdSsSsoNkR8xZ86VkSDiP/2Hb8TXf2szTrC7SOhbCflatvm+ErE3ngJLYkfJQgmkoJ
         hHXhA14Oy796z0v4bq+KENmudoQ7O8YMHdyFx/g8NbphhGTy2h3/CNEuehe1UvSr8nL2
         ckrcxWV6zC/QS/qcQ8XrJ4uJ4JVFhyvxxocxh2uHPSll4i2jCxVEKGenz0zFp+z9Adlt
         /gp9WXivzjSo6CtxgpguO/HRBXrumfEZlMpXHvoBJR+v835Ze4FN5J2CLLSDvuU1EkoM
         WTb6UgBRnsbZiWJ6XBfrS3XPxZ7VwLlEf4n4tHR+Dbjehs9xilepDZKYJmyVzDBrPL4o
         klmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788467045; x=1789071845;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B8uOzk5kbNElpXD3JZXWiXWL8uLf97nPgxHodv2izOs=;
        b=SB4Dkw606R8WdtLOmzcrPMQBtYSKEvnMu+2M4x1VY5LZD65H42zZxQB0ppy5nc75j1
         VjrblmcwlnQJnn0zqM3wd5cWQnF1t1AfRqr27QhLBDlrTXRRgXm8hmAoyttNs+ws/miJ
         4Z+HPmgj/cdatj6BLiXtHwWdqYQPKOwiXcvj+tEG6tJxQTvKHYCCSzcd1xGslIPMH/bR
         6LuCqKGMtOrDXSuy4eY/thhsrME6JNa5a221wHqYqrwGPXvq2L7jDcB7GLgTM7o5Q6fx
         IAYJbBLiaeyDRuie2+zrFNpgABcKTZaD6NSWGwtlrbTXUUPguZ1xhK+0AvwZ3mrK4mI8
         oxug==
X-Forwarded-Encrypted: i=1; AKwUvByvdiON1aLrSEvjyZ1dVuOLEwmwVr/65S9WqQlOqagv8U66CcUuD7NeXUxNkWF3BR29qzP5vc7u4OulUoVzh585NqOcwhM=@vger.kernel.org
X-Gm-Message-State: AFuF++keKBpOMoC33jPViPnQNI5xFGUHwnADamptbi5S62OFOrQxRR7w
	YUO0Gps9OdBraLkXc00hvavdEetAWQFu2hSncUCsFUt5BH7wOrJ5QVmw9sOaQtLm2TO51wbbTii
	cA19Obw==
X-Gm-Gg: AYBFou31UE1odSeAg4WMP6D1q9WXMXW/rO7eYS6/9/Nz9WCtEC9LNubXsU8pGmRPHpv
	P0mWg2XpxyFfGU+NzwctDYpESd1y07UagBPVDovuXX3zhT15q5UGzUqr10qjKxKxsQlFj63OPd3
	0SEkVRBG6Qb5qlb3ddDZ8AXSu9aMZKwJt5cw0BfrOE/C3k4C53vD7TX0oeMGhYPncMcBNqSWgK1
	D5UTTVBdbs8OQmCDQTZ4X7GHglm0p7P04tOE9dABV7twLuD11t+bMxZgX1M+ikvxVDC5AmYorhZ
	P8+sfr91THLoVR2Hj+TXgoEHIjI1UIKnKUwPhR2bayiefgztirTJohUuAAkgV3PlvuDw4gX4xeb
	gmqVaO89ORLsFdE36zpAuaMxW2LZds3P0slbm7D/k2l7kMYKfwLtLJPEQzHXZjrhGi+0e2YJoNs
	jI9HqLhFMMi1kdoOxkuH2MWmsWGE9ta3vhseKvQVQs2UqpQigrIDbRhFolhzfPZICk8Vl0aLtIx
	J7nGGu2hwsuIMXI8QMDO3ySPXBytTE8BQ==
X-Received: by 2002:a05:622a:114:b0:530:42e5:f3a9 with SMTP id d75a77b69052e-53054a10750mr15915981cf.44.1788467044885;
        Thu, 03 Sep 2026 13:24:04 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406871b6sm3176156d6.32.2026.09.03.13.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 13:24:04 -0700 (PDT)
Date: Thu, 03 Sep 2026 16:24:03 -0400
Message-ID: <763ef0523ed8e2e25ef5b902e21b0c53@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260903_1622/pstg-lib:20260903_1620/pstg-pwork:20260903_1622
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS, mailmap: update email address for Ondrej  Mosnáček
References: <20260903155615.516010-1-omosnacek@gmail.com>
In-Reply-To: <20260903155615.516010-1-omosnacek@gmail.com>

On Sep  3, 2026 =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com> wrote:
> 
> I'm going to use my personal email for kernel contributions from now on.
> Update MAINTAINERS and .mailmap to reflect this.
> 
> Also switch to use proper spelling with diacritics, since I normally use
> the full Unicode name with my personal email address. I'm leaving
> in-code occurences unchanged though, as that would be just unnecessary
> churn.
> 
> Link: https://lore.kernel.org/lkml/CAFqZXNvOGbzy8-ZnJtKi94jfu2H173Tz7VYpK8KuseMQS-9tNA@mail.gmail.com/
> Signed-off-by: Ondrej Mosnáček <omosnacek@gmail.com>
> ---
> Hoping for this to get picked up via the SELinux tree, since the main
> change is in the SELinux MAINTAINERS entry.
> 
>  .mailmap    | 1 +
>  MAINTAINERS | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

Merged to selinux/stable-7.3 and will be sent to Linus shortly.

--
paul-moore.com
