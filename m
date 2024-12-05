Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD6D1C3F1C
	for <linux-security-module@vger.kernel.org>; Thu,  5 Dec 2024 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396015; cv=none; b=jV4lEDzVAMFk6mpPqkX8FS1L02z4rGDw1Ix0LDS2Ewv++zwyBAxZ/dR5+2WMv6qJDb5bP8hob4jgMCC9kgBBCX9HL9Xy/aInO0WaE+AVCrHTQPsZJ0FS8882GUEEUs1ygUWI/+TOxKUZzHWkRWhmea5YMVWACt/UueCp7/Zg0dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396015; c=relaxed/simple;
	bh=V7TDcfBuyky5UsKZRbY/kdI8U0JTK2PgSkZNRMtSVHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2sZIr7CPlB5/gddpUbCwnntOKA8cdgvK5uYqTPigZo84vU3MnKNuF0gsRGeBIx7hrb7CcO68cpu9cWaLzHKEOxUi6nHxvLSzvwVN8Dp9KBrxr682iBATxvJ+hFywfd5jgyZI2qF9VxKGc7XgqRbskgkVZdQLOaXey8Y0ZG07+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1MSiodC3; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1MSiodC3"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Y3rpZ4r0CznS;
	Thu,  5 Dec 2024 11:53:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1733396006;
	bh=cTdGME8xOveDjt/A541FRkracaMRa2kD7BqhDnfiQ5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1MSiodC3yO84x9ruBw8LRr0ArJoSuCIdfqGZ4KKWrBW6uX4L3hoeQqPpWoYwYiCI5
	 WUuQSLzxs8bbIGUmpy2smurAVkuSf4NEVuqCp0nabu1d7yqINrdz0Dt7V+dCD6OfnA
	 tmgo9xHpaRvxHHKsOsPkrKOlB2Vn4EOJaVmHuWQY=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Y3rpZ0PF3zK3H;
	Thu,  5 Dec 2024 11:53:25 +0100 (CET)
Date: Thu, 5 Dec 2024 11:53:26 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, 
	roberto.sassu@huawei.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, audit@vger.kernel.org
Subject: Re: [PATCH v2] ima: instantiate the bprm_creds_for_exec() hook
Message-ID: <20241205.fien4aet3Jae@digikod.net>
References: <20241203233424.287880-1-zohar@linux.ibm.com>
 <c1c61f20-a4ee-437f-840b-2433345e74b6@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1c61f20-a4ee-437f-840b-2433345e74b6@linux.ibm.com>
X-Infomaniak-Routing: alpha

On Wed, Dec 04, 2024 at 02:01:02PM -0500, Stefan Berger wrote:
> 
> 
> On 12/3/24 6:34 PM, Mimi Zohar wrote:
> > Like direct file execution (e.g. ./script.sh), indirect file exection
> 
> typo: execution
> 
> > (e.g. sh script.sh) needs to be measured and appraised.  Instantiate
> 
> If I understand the underlying patches correctly then 'sh script.sh' would
> be evaluated with execveat(AT_CHECK) but this requires the execute flag to
> be set. To maintain backwards compatibility  sh cannot assume that script.sh
> has the execute flag set since it doesn't need today:
> 
> $ echo 'echo hi' > foo.sh
> $ sh foo.sh
> hi
> 
> the same is true for python:
> 
> $ echo 'print("hi")' > foo.py
> $ python foo.py
> hi
> 
> I am not sure which interpreters are going to be able to take advantage of
> this or whether they will behave differently if the x bit is set versus when
> it is not set...?

This is a valid concern handled with two new securebits.  See the
related patch series and documentation:
https://lore.kernel.org/all/20241112191858.162021-3-mic@digikod.net/
