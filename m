Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C633191CD
	for <linux-security-module@vger.kernel.org>; Mon,  5 Jan 2026 11:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611061; cv=none; b=qILDPj3oi6MhIBuvbai61HECsoncRxegCLE4E4IxIwOuwGbE7HPwowJRJQXTKC8wQpiCA+3ZxJ++9DVBLmZthsOJsCN+O3qUFZpGsjGToumvIBrCUyoRx23S4IQ7gOnqU9CNHsI8+Mao7E76Fyk6TD/lzxOuftWw5waDi642VVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611061; c=relaxed/simple;
	bh=pSQjuOI9wcLr08I8TyNDVDtZ+plM1hk+1WUrJMqKsKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmHRadc2saVRr8ibj9wvOwxSoJu7GUUM9yUcaj01cW6/BhFSjy57bEOFaeaM2cwq+jVTu1FbosTSJxg3XIq78kjG+xRLbgpIizQhCfc9NV+FD2LUpEvPF/T4z1K/ZQJGqYdUasDl51eiusJO+rwsM4gtETcnV0e5POL8KBtv9S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DqeSUgs/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DqeSUgs/"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fbc305914so9422969f8f.0
        for <linux-security-module@vger.kernel.org>; Mon, 05 Jan 2026 03:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767611057; x=1768215857; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gp32gXZBzPi/+owIIcw+ejy/cxTPqGdSU5O8VFJVUqg=;
        b=DqeSUgs/AY8NXTj6tcgmuDC0oiqzBAghqD1pWz8w4QEOTkTGASmr6K3MK/LpKyhGhE
         DqWPRYwk5boNpRN7HFmhYgyBcTWyNJDGENPUg3m/zdrMA9Gs4YVr24x3rL/WykEOQvs+
         PNpytfGxyhQ+SbVJZ8gkCkeL+2E/IxPpMZSRyC17Gfobe/fgvvptsIDTYknq95Nc2Y18
         OxMYCnLaIRELBrBn6fk0upyeiGkeJjVMsgzPwDdpxY6+qQ+fEkT3GwM96A33wu2DgsoX
         p7sB1x43KjjgdcacyXwkNXBQQlxM6A/xCC7dg5O+jtzzZISPWkRrnQwAi1kF8HPErGMB
         lPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767611057; x=1768215857;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gp32gXZBzPi/+owIIcw+ejy/cxTPqGdSU5O8VFJVUqg=;
        b=CTQml+4eWbK6/jyYZGEED6a08DzMc8Wdo16scqqbDbhd4CTlysj5F0rYTd6MZMyyRP
         2ifTxF1uOnkcs4FAc3zo5UzrT7PWPDME8jtDQDiYXobT2KFWkni3+cKPhhLJQWB5jJmN
         0zM9zafFU54JMOLTMRsoZPhtQSm2eS/Az4qJtbTdLk2o6LycXuA9bTRuNvjN2zuKVTk+
         JsdvzG5hCNlzaUH8agDTTj0JHn+vajCuPHjiCR9AwN2K72aMsCiDY39hyVqrGkGrmGrW
         +2LsdfviNmOFptJRjpeyRLVsqGodI1Mil+qsoUHPeBXJyB+GN3xXwWDqAf7KbcxU/rAU
         K0wA==
X-Forwarded-Encrypted: i=1; AJvYcCXg6QU6tGl5mhUe/X/xsddYGtYMsLlyUWqo7+e5bEqvkRHX4rgoAZzGgIrwXyQUI63jthr0THfEkS/tHxcljSmbTYChDr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt45Wx2DakUvgewfVg62o+Hd3oocdzmOnPdJD8m0FC/a/fJUap
	i5JMBGX98h/ghCdMkxk+yMOPDa9YFg8nFB4Wl4s7rzxpG2nMsU3YAUtnpX4SO2CVCA==
X-Gm-Gg: AY/fxX6XLHUoeQuhM4l3z2TQvcQLbJ4dvunuc0iLiwF2PN9VJangTJagDu2mTphrT/e
	zRWOLBTe+5xZqTWuEP04KZS+Ie6zTJs+FPAtdDAp5yfqKstfCeJov+e+ctY8NcOzrqRyRm7Jey6
	wFZNgdqDhovP224T3M9rLL8DZ26j4n4P3uODl4ND9Psi2yHYVU5X0q9RurccMgO4kCaBgwyhxSF
	FmflOK2tV2plEkVeE9FLWdtMGnMWVIo9FtVKjEkIVy1w9KCPl4YkER6TvlOt/gZ38t6+Y9pjnZX
	sK8N+mad0QSw1tuwDLD8s0TCUdcbVRGno/ijN7QEBxWrKb+MFjIkxoMyEC5i15ewGLCkLRWVyd3
	ACS66FLjsI1vngi3EE6LJgYf+qmDMWdQ7g3XlZpfAQk7ka27HIh2AFtbr5xRLX0WhHWT3bglYCx
	2EuyjHlozxlyLmDE5jxmzTMDz4/QW3SoDAA0ITVUs3WvKEVZmHzRwD
X-Google-Smtp-Source: AGHT+IG9vrBLNBq0MW+dkviHnF4LAt1RYyyrv14vSAjsaEoJzVASiZBHgrBaKHVi84I/vsKswUQRZQ==
X-Received: by 2002:a05:6000:2c02:b0:42b:4267:83e9 with SMTP id ffacd0b85a97d-4324e4c73f3mr57556292f8f.2.1767611056658;
        Mon, 05 Jan 2026 03:04:16 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:8034:c3df:e486:e883])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea22674sm101510889f8f.10.2026.01.05.03.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 03:04:15 -0800 (PST)
Date: Mon, 5 Jan 2026 12:04:10 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Justin Suess <utilityemal77@gmail.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Simon Horman <horms@kernel.org>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] lsm: Add hook unix_path_connect
Message-ID: <aVuaqij9nXhLfAvN@google.com>
References: <20251231213314.2979118-1-utilityemal77@gmail.com>
 <CAAVpQUCF3uES6j22P1TYzgKByw+E4EqpM=+OFyqtRGStGWxH+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUCF3uES6j22P1TYzgKByw+E4EqpM=+OFyqtRGStGWxH+Q@mail.gmail.com>

Hello!

On Sun, Jan 04, 2026 at 11:46:46PM -0800, Kuniyuki Iwashima wrote:
> On Wed, Dec 31, 2025 at 1:33 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > Motivation
> > ---
> >
> > For AF_UNIX sockets bound to a filesystem path (aka named sockets), one
> > identifying object from a policy perspective is the path passed to
> > connect(2). However, this operation currently restricts LSMs that rely
> > on VFS-based mediation, because the pathname resolved during connect()
> > is not preserved in a form visible to existing hooks before connection
> > establishment.
> 
> Why can't LSM use unix_sk(other)->path in security_unix_stream_connect()
> and security_unix_may_send() ?

Thanks for bringing it up!

That path is set by the process that acts as the listening side for
the socket.  The listening and the connecting process might not live
in the same mount namespace, and in that case, it would not match the
path which is passed by the client in the struct sockaddr_un.

For more details, see
https://lore.kernel.org/all/20260101134102.25938-1-gnoack3000@gmail.com/
and
https://github.com/landlock-lsm/linux/issues/36#issuecomment-2950632277

Justin: Maybe we could add that reasoning to the cover letter in the
next version of the patch?

–Günther
