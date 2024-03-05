Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784F7129A99
	for <linux-security-module@vger.kernel.org>; Tue,  5 Mar 2024 20:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670712; cv=none; b=h9hUJdSxoyx71GjZugkH28aDkaEBnnejInsG+xVFqHlpgNhBGBI9ciT/PUOkZ0zJcz27sS5aVx+kpgDTV3noUclLEV+Giw8DUe56oFThVG99wkx0qEbdn4fkQ9zWM1fiL/vmJjXNHin9rg2x4vRBTGE0CyxSGq+FY9J3FInYWTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670712; c=relaxed/simple;
	bh=pw3G19sacPvgxxjDa+F7GfDDZnTry5voAGRccl7XUhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1KtwKxlhqjNlv0O77qZFftfpzqXhYIiWBWb39jFfr5JWgXDSh0R2gTmjiV+X4wtpRYAwz59hnbhBWcfT+FnSsSWx6EcK8SEvonMeB0vhH5MKPkdPhW797SPKlMBMYQM+pVZwZoX5XB2+7GTlFL93o2P8RQrP8tZf45AqLnGtwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JhjhrrLe; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JhjhrrLe"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e64a9df6c3so51332b3a.3
        for <linux-security-module@vger.kernel.org>; Tue, 05 Mar 2024 12:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709670709; x=1710275509; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4EwXdmdUlhrJr7UjQPFyD/UJ5/e0VwSFBZlmIPUM/vk=;
        b=JhjhrrLekNSFp/aKxTSWqR/6QpEKkt+GqwB7duR/KKTqfD2CKo5HNLMkIlR8zas4Td
         m/DhF3HpVAomF5iWm/eIqwxxKv9ew5oSSBW7BtIsgNz7ed5K4j4S9Qix1IyJofElVw1z
         fH0C8lejeJK2S98fleJvSV4GvXSbtElR4jpOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709670709; x=1710275509;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4EwXdmdUlhrJr7UjQPFyD/UJ5/e0VwSFBZlmIPUM/vk=;
        b=OWQhhUv/7tDLezfXvc9P5rk68fRPLeNZzuLy3XAXS41089d/v/6/ntGOBZ1Tqa5tNA
         FOcpvD9fQ4hDbXjKp3wbt8iqk8ZE9fwMVWb2doAJ/7L0EMlnLAAFTi53u3YT229oIqge
         RY778Nsy2b1iV1d0znnm6/dScQ8Skfvqi1pRL1w7W5iK08BZajrR52Qd9FsjvbTINB2x
         EevxYJq0qvDoFFVFIiPWyfCGJerBgrcH+jrUVeeSh5aKqK7rgLyt/1zyd3uw0wSACzeY
         kh7j7CqOxkJVbn3URmC7qG0cw6WZsoMNm7Q5USQW7eesPLPxqqhkfr3LqkFiSvdzov5D
         P3jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnPbO0X0mXJKz5CeAp0/lqU9rEQHiLTKuUkGQixytoc4I9qpSA7XMwU56y1N9zoSVsZC3OI1NnC5l+bkHkuCnepNnrwXIx2Vv5XuJgp1DpaHimA4yv
X-Gm-Message-State: AOJu0YzirLn5im2Dhmtfnap7oCU4+iX0kgNJTrExZ16M0tbpt3CJURXn
	rOVO0T0uNxUk+irUKeYHosjQcbyAjtNZxnUiv4yr/MPq1Ch9H5ll/ZQuJXD+aw==
X-Google-Smtp-Source: AGHT+IEWfc2imOj+NVA7L8pf1cvVI2z/GXhu88fbePla33Jy8RW0G93koevb4py4GfPpafR7599Vlw==
X-Received: by 2002:a05:6a20:85a7:b0:1a0:e1b6:4306 with SMTP id s39-20020a056a2085a700b001a0e1b64306mr2544108pzd.57.1709670708732;
        Tue, 05 Mar 2024 12:31:48 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p20-20020a62ab14000000b006e47e57d976sm9354568pff.166.2024.03.05.12.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 12:31:48 -0800 (PST)
Date: Tue, 5 Mar 2024 12:31:47 -0800
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Will Drewry <wad@chromium.org>, edumazet@google.com,
	jakub@cloudflare.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] selftests/harness: Fix TEST_F()'s vfork handling
Message-ID: <202403051225.B2ABAC80A@keescook>
References: <20240305.sheeF9yain1O@digikod.net>
 <20240305201029.1331333-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240305201029.1331333-1-mic@digikod.net>

On Tue, Mar 05, 2024 at 09:10:29PM +0100, Mickaël Salaün wrote:
> Always run fixture setup in the grandchild process, and by default also
> run the teardown in the same process.  However, this change makes it
> possible to run the teardown in a parent process when
> _metadata->teardown_parent is set to true (e.g. in fixture setup).
> 
> Fix TEST_SIGNAL() by forwarding grandchild's signal to its parent.  Fix
> seccomp tests by running the test setup in the parent of the test
> thread, as expected by the related test code.  Fix Landlock tests by
> waiting for the grandchild before processing _metadata.
> 
> Use of exit(3) in tests should be OK because the environment in which
> the vfork(2) call happen is already dedicated to the running test (with
> flushed stdio, setpgrp() call), see __run_test() and the call to fork(2)
> just before running the setup/test/teardown.  Even if the test
> configures its own exit handlers, they will not be run by the parent
> because it never calls exit(3), and the test function either ends with a
> call to _exit(2) or a signal.
> 
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Günther Noack <gnoack@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Will Drewry <wad@chromium.org>
> Fixes: 0710a1a73fb4 ("selftests/harness: Merge TEST_F_FORK() into TEST_F()")
> Link: https://lore.kernel.org/r/20240305201029.1331333-1-mic@digikod.net

Sanity-check run of seccomp tests before:

# # Totals: pass:70 fail:21 xfail:0 xpass:0 skip:5 error:0

After:

# # Totals: pass:91 fail:0 xfail:0 xpass:0 skip:5 error:0

Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>

Thanks for a quick fix!

-Kees

-- 
Kees Cook
