Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DAA307AF3
	for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 08:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763628536; cv=none; b=RPDyUHGLnxkYB02v/eYjvwU2Z31LIereBEFBT9wD5I2ZOjKPbBcaSQzVZYoXOhlrwWxy95mZ0e+kAiVkszG9wK45KUjXvZKeo1vM7vKKXGWmMdMFv1/dQuUZxt9KcNi3thTKYqDDsI5uIQSE3tilypC2//M+ZOiV3zu4DXg6CEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763628536; c=relaxed/simple;
	bh=UYCeCV7SxF7B0ZWoXeB/kdyuO5q1rOnca4ZTppc0z8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPgGPjjgVLP70vW5+P50rcJDGOa7w13hhdH3lWhKBuTZwdrBqfOuMHoZNneqRD0aCWC1y3zFOOW9P8C5/ONk6jCNZ1oBXjStzyx+7Sfde0ARC02Ql4je4FBMb/on/kT8/f4rkZ/Rg6QE9ItZdOcvWORb8nTXZP9lQSSlDuO0I84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3IHK2bF; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3IHK2bF"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64175dfc338so1076944a12.0
        for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 00:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763628531; x=1764233331; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eudORTV3HI7IXmvYPGw5oPoaS+974F6g5e+0qgd+ufw=;
        b=V3IHK2bFuO5uWqbGkq3QcRTsQK6zqSS4OI5APcEblAOrnDIg0YbeyvKkHPi+z39juM
         oS4+VO4EWwDlkqDNe4jKlkhfQJuk8wkbu4A4G4Ekg8EANECGdw0Ux5rZCLzeZrLdMfJn
         3HNUCg9ENyQQHjPRGC33hJAaI6PEIzB/wPazVHbJ2ZwnINfCmrHvMuag6lSI695ZhTsF
         J0uuUweIS8weJHGixtrWtluKPWB/kRnEWhHipM+vdDXyCuaQyE+uAnPM7rIdpnZ89vkL
         IY5xLqJ/Bz8Ga6htdtGDRcfmnjYkxnqCzbpCBGxZAvVUimlkaB6osuwPxxsSzvuU91yg
         uXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763628531; x=1764233331;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eudORTV3HI7IXmvYPGw5oPoaS+974F6g5e+0qgd+ufw=;
        b=UnjJAV1aotE0BIc+Ex7VEQ5cToDKiD+RYgttLCYQL4SVJk84kgI2kNSChEv/f75/DJ
         SK8vO/Gclodf6bGrjpLfzveui6/BNMiYUqYl6cQti3mzzwjsO516LbEm9ISOhQDJhUU4
         MX5JzZCshQpOFDVrUsBYJgPkLh1pUqsAHQAleicRdHuDBwA5gReJ5Ifbb4Ut5dznQizR
         zvoOSvaSswXVK6mS2aByC7YL076D6IHSJtkFYjJjdhi9lFF4fd4G0UyLGhYup7/C6uGl
         fVd9j4zWDojD7jL4dAAdQkXMBK3LyU8w1CNpNYds0h4XT1Tk/AoBDlYYOSriV2sjsX2e
         c+/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmiNhTnvXr2t7VQzq777TDsoUGRszmRmw5E8lKeOwTa4YgMJTkj+JqN6tvbJrISBaMqNpMB1XLbLyQd16QZDP/fyDYnvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkxq+/927G3VttNur3XBBIWyz/bJvA5zOC31HhmFL7KxeJiaCT
	kYwGGxBTxkbL6gvm5QysxJPYxffBWaRx8a4txdkF4PyVOdn0yZs4k9Ab
X-Gm-Gg: ASbGncui1NDv5dUxnNX66grvZUfKHH78voe3H1BeGJXa913vWw7bhmBbTPNhmS0hm4J
	vd9RXoYOyijjkDS/nGonLEDyFKK+pnXAfEOwz2U8QT8Ymgq3f4f+Hir2MW9KuemUg8mQGfOWXS8
	htGy4ym78d0lvHHRoBgQ9vqPbiKKKYbQ6fj20HoEHbpPEJZF/PCM7f0cYswfOTR1VhJEUiHeCuI
	YBYTgist9cBEmtELFpKECPWU2QNmXMGiiNUQrJdNLRj8oHlCfNeLU2uT2cfFMMLDWD6GGgSH0BR
	d9aElXlVxJxG/gLlwf43u/HTfwS6GnVBLVb/om3KGbAsqHuj7eUQqJSqM5/Hj6tzGdiWGkdQwjk
	Tdn1y8l6Ivn8JuZkbC6QrDrLIoCNYw+TSerEB3Bk4daClnm4JjLSvFzR2n5Y4O+Z5UlDoDEXLub
	SlHUOOHhI=
X-Google-Smtp-Source: AGHT+IEkRkLNFDvdfRty02CSpceZRVXP0vj7VQbkZjvo/RAJBZ7oofMhULkTmpVfn0lYCGNaJSGyWg==
X-Received: by 2002:a17:906:dc91:b0:b71:df18:9fb6 with SMTP id a640c23a62f3a-b76554f2f8emr217731166b.26.1763628531095;
        Thu, 20 Nov 2025 00:48:51 -0800 (PST)
Received: from localhost ([2a02:168:59f0:1:6ea:56ff:fe21:bea7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d7cafdsm156312966b.30.2025.11.20.00.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 00:48:50 -0800 (PST)
Date: Thu, 20 Nov 2025 09:48:43 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?utf-8?B?6K645L2z5Yev?= <xujiakai24@mails.ucas.ac.cn>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Subject: Re: [BUG] landlock: sleeping function called from invalid context in
 hook_sb_delete()
Message-ID: <20251120.c5c17c664315@gnoack.org>
References: <20dd8187.9d18.19a75eadc43.Coremail.xujiakai24@mails.ucas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20dd8187.9d18.19a75eadc43.Coremail.xujiakai24@mails.ucas.ac.cn>

Hello!

Thanks for the report!

CC-ing Mickaël, who authored that code

On Wed, Nov 12, 2025 at 10:35:17AM +0800, 许佳凯 wrote:
> The call trace indicates that hook_sb_delete() holds s_inode_list_lock (a spinlock) while invoking operations that may eventually call iput(), which can sleep.
> This violates the locking context expectations and triggers __might_sleep() warnings.
> The issue seems to be related to how Landlock handles superblock cleanup during security_sb_delete().
> 
> 
> I’m currently only reporting this issue to the community; the exact fix will likely need to be confirmed and implemented by the Landlock and filesystem maintainers.

This looks like a false positive to me.

There are three places where iput() is being called in hook_sb_delete,
two of them are in places where it is *not* holding the
s_inode_list_lock.  The one that *is* holding the s_inode_list_lock
has the following comment:

/*
 * At this point, we own the ihold() reference that was
 * originally set up by get_inode_object() and the
 * __iget() reference that we just set in this loop
 * walk.  Therefore the following call to iput() will
 * not sleep nor drop the inode because there is now at
 * least two references to it.
 */

That seems to indicate that the sleepability concern was taken into
consideration.  iput() only sleeps if the refcount reaches zero, and
if you can exclude that, it won't sleep.

—Günther

-- 
