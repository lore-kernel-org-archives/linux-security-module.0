Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3093289811
	for <linux-security-module@vger.kernel.org>; Sun, 18 Jan 2026 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768758310; cv=none; b=nGDEsqCZkfp/PM9Ar+tpcnQCswrNh1FXNcoxwbGLjD700AiobbhEdNgrLJa1pAWLBEYlcBF7egHMDd/VttiRMpIRlGfJ9zchLweJN9Ucjr8ckfqTlZmonxo5jiZ8XtpcwnPVyQtzzoStPDphCBEFbxRPOoZfmNmZcYtpe+7uWrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768758310; c=relaxed/simple;
	bh=s0irCw+gMjmzH65mBrP4Mzm7/teDdFv8COtAVdp7uJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeNIoco0D0nryZ2RLmvHg2pEyuSUQ7eWChdzObrPrC+d2V5gJ8e8Igz+LOikj8PCaYLEMlOvejwI2H+HULjODB4tOjiNhmvv51EIcuNb/Y5vEg7sJojIRaDFmc5urFFxYyxD9y3KBCNYgjr9hzVYHUXgIg8kpcRcT81ePeY4TqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jx+Hh6yS; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jx+Hh6yS"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8765be29d6so520064066b.0
        for <linux-security-module@vger.kernel.org>; Sun, 18 Jan 2026 09:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768758307; x=1769363107; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+lLGRI572lOA24qrLkpQ+3948vS4VnXxEWoByvnQJrs=;
        b=jx+Hh6yS+aE7WsNuHxm8uVup268woTU9vdoJdTYL7xiMh9b10/sO1kNI7GLEKNSucN
         fjZxHXusAjp2MsH1AgXdTi5qSLYn77H6oncJd2jV5+iv3VojzU9wFqmoY5lsPEd1PJ4b
         2IDbN+yZIzCGcARTre5xWNimszoIq9dUHHNzEynDpDHxWeloSYfBAa4ry8VHJ6iYsCya
         RWNejxKJp8FUXi48p9uVN44NXCwp4efNbLts9lvW9a8cFgvfUQxqMqsISaiNFQ3TVyPs
         wHXy0tAaNGMxWb2PUfc8De0G+tyWdBqn4BSwiDZmdBckoL1SsLmsLd5/lqUpPi10Uyer
         NRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768758307; x=1769363107;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+lLGRI572lOA24qrLkpQ+3948vS4VnXxEWoByvnQJrs=;
        b=POxkshURDqKwRH8IddBZr/oEal3Hp0jsrnSU7jKDTAYjz2uM2j8Fgm0pas/v8dOJxo
         7NB0wgTZtdjmMh3UvYdG4WwGiaAjX5hWPadkbOqHVQ3DxEUcCZLhh6M7+P+RFUGYMfVM
         peb2bUhmRVnKENfwgz48SA0MNEQIr/g2/x4g1RpFr8KhAKplBff+D6p2S9UbYjS58Qh0
         /yu6ILb3TujD+FlWIxf5lbRrhqZd0387aaRFyY39lEAiAaMGspaX2LP4dTITVXNVUoyP
         EMlgM418qda1GD5Gvtmxls+78R2ZI8+LBDGR2OtzXrrEC7ziw6enxxex2TTSVKObiSDh
         nQLw==
X-Forwarded-Encrypted: i=1; AJvYcCUJhnWKZyCT/CAOg3mpNeywC3vTD/u3kfx3ym2BR7SMmx5lJe9KFrh8eSZqaeXif3kEtNSSzjTfnsGIZqVts1oPO6p591c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyux0rt4SU8BEGGoXTuyl0nbx/MbtxPjSEIuy0Ljq85274NtuCm
	8Mb2DxZ/3NsxXqRGpPiaRVsNvn27TaPKjHbfBLvbWLNwzyDblwxWuqIL
X-Gm-Gg: AY/fxX7cSgWMjycu8GcR88/FP60we8OgR+//4Fdz8sAM0ryVtWd3O1kph6HWlXQJqh4
	FEQIqxadlkbX3sOa3QlTcoBh37rHr8gWrwNF610ybW8quryayr7E3Dit/MCGc5MedoNWTYv4CW9
	PDPsDrVuI+bU2/7CjXccJFYPcXc+7usHMXSwqdKap2ePnLozwCp24rJO/8aEtOxn2+nhBWW9Nsk
	XSIC50LP+Ro2BUhIhoAZt8ItyM/s3VPIxUXy5EiEwHAInNd5dUeL3gwrEuZq6QpRiI6zQXylOOL
	ABk/FaB5UPvEoJuGEK672/NQctkoxbhVR9WCFBr43SKZJx43kC8yNYgywiG+RAc0YOTXLepxWEX
	S6/cebRunpHjjsSMtar5R3KEQXW7Tk6sfsisoV0AXWiWI7tjU+IrS1EMNZITkkJtJUjUSrB5iSe
	WPMFU1LH3I27FvePClsHHjzVQGdHWWgFkNphIK
X-Received: by 2002:a17:907:c0a:b0:b7a:1be1:983 with SMTP id a640c23a62f3a-b879324ea84mr842454266b.63.1768758306343;
        Sun, 18 Jan 2026 09:45:06 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c96f4sm874098366b.40.2026.01.18.09.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 09:45:05 -0800 (PST)
Date: Sun, 18 Jan 2026 18:44:58 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 0/5] landlock: Pathname-based UNIX connect() control
Message-ID: <20260118.a37c57a422d7@gnoack.org>
References: <20260110143300.71048-2-gnoack3000@gmail.com>
 <20260112.Wufar9coosoo@digikod.net>
 <20260112.a7f8e16a6573@gnoack.org>
 <62eda124-de91-4445-b163-9dfb8039d08c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62eda124-de91-4445-b163-9dfb8039d08c@gmail.com>

Hello!

On Sat, Jan 17, 2026 at 01:57:20PM -0500, Justin Suess wrote:
> On 1/12/26 15:53, Günther Noack wrote:
> > On Mon, Jan 12, 2026 at 05:08:02PM +0100, Mickaël Salaün wrote:
> >> On Sat, Jan 10, 2026 at 03:32:55PM +0100, Günther Noack wrote:
> >>> ## Alternatives and Related Work
> >>>
> >>> ### Alternative: Use existing LSM hooks
> >>>
> >>> The existing hooks security_unix_stream_connect(),
> >>> security_unix_may_send() and security_socket_connect() do not give
> >>> access to the resolved file system path.
> >>>
> >>> Resolving the file system path again within Landlock would in my
> >>> understanding produce a TOCTOU race, so making the decision based on
> >>> the struct sockaddr_un contents is not an option.
> >>>
> >>> It is tempting to use the struct path that the listening socket is
> >>> bound to, which can be acquired through the existing hooks.
> >>> Unfortunately, the listening socket may have been bound from within a
> >>> different namespace, and it is therefore a path that can not actually
> >>> be referenced by the sandboxed program at the time of constructing the
> >>> Landlock policy.  (More details are on the Github issue at [6] and on
> >>> the LKML at [9]).
> >> Please move (or duplicate) this rationale in the patch dedicated to the
> >> new hook.  It helps patch review (and to understand commits when already
> >> merged).
> > Justin, would you like to look into this?
> > Please feel free to copy the wording.
> No problem.
> 
> It's quite long, so would it make sense in the notes?
> Instead of directly in the commit message?

I think including it in the commit message is what Mickaël meant here.
The quoted email above is already from the cover letter (which I
assume you meant by "notes"?).  IMHO, the considerations that are
specific to the LSM hook are OK to put on the commit that introduces
it, even if they are a bit longer.  That way, a summary of the
tradeoffs also makes its way into the overall commit history (unlike
the cover letter).

FWIW, commit messages with long descriptions are not unheard of,
e.g. commit ee6a44da3c87 ("tty: Require CAP_SYS_ADMIN for all usages
of TIOCL_SELMOUSEREPORT"), which I submitted a while back.

For reference, the official guidance on commit messages is
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes


> >>> Seeking feedback on:
> >>>
> >>> - Feedback on the LSM hook name would be appreciated. We realize that
> >>>   not all invocations of the LSM hook are related to connect(2) as the
> >>>   name suggests, but some also happen during sendmsg(2).
> >> Renaming security_unix_path_connect() to security_unix_find() would look
> >> appropriate to me wrt the caller.
> > Justin, this is also on your commit.  (I find security_unix_find() and
> > security_unix_resolve() equally acceptable options.)
> security_unix_find works for me, and seems to better match the hook
> location. I'll send an updated commit.

Thanks! Please feel free to ping me, I'd be ready to send an updated v3.

–Günther
