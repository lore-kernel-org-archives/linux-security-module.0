Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EED19066B
	for <linux-security-module@vger.kernel.org>; Fri, 15 Aug 2025 04:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755231040; cv=none; b=PPzbjM2LKSZ2XQ3PBXclhaZRKOZspy4gW/J1Vr/8ZSIgsCUlq9q1/b1ckFzSOxFA2+kkvoUCv22Nu7vvoMPhM0LzpuLEV5BW64a9c2ht2JfUSBMcreNMm0yPhCAkejhANlIARhURJ/T1UxldSOhvKJd0tFuZNpWk6zBCAbuQSZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755231040; c=relaxed/simple;
	bh=WpFNvbaWQVIp9vddf/wtaqzKr6XUIX6RAmlpXQcERDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwnWilzUEeNPkTnOgOzhSWmtKUnemOBUOiOTfjYtndJYF1HkFf/GdkiExwONkZWl42VoG+jhFV87JVfa2bZLCpUllpvu8cNhIPBYsHSjqrNBepJxdP5IgboQ9PQ1bVjuPOWeDU+8dUMUjPgfsgJnw4rlVlcMXSTmHLePxcbmaZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=eKOS+99W; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="eKOS+99W"
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id C22641018FEE
	for <linux-security-module@vger.kernel.org>; Fri, 15 Aug 2025 09:40:25 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in C22641018FEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1755231025; bh=WpFNvbaWQVIp9vddf/wtaqzKr6XUIX6RAmlpXQcERDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eKOS+99WbntAeCs9jzvkG44S1wixeP9Ar92DoWpRLNAyUttrdROV0jSQJ+2t5pHiR
	 tlIfm25OA5RV6edxitScd5TLDg/2JTKCCuLdFGSVhUJfjeymdnqO3SJpb77E4yTfjo
	 l4vkTV32NGLgI53Z6zuR3fKTOCOLr9aB9fYeDkaA=
Received: (qmail 10064 invoked by uid 510); 15 Aug 2025 09:40:25 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 2.190701 secs; 15 Aug 2025 09:40:25 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 15 Aug 2025 09:40:23 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id F0F9236003E;
	Fri, 15 Aug 2025 09:40:22 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id C2BBA1E813F8;
	Fri, 15 Aug 2025 09:40:22 +0530 (IST)
Date: Fri, 15 Aug 2025 09:40:18 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
Cc: john.johansen@canonical.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	shuah@kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] apparmor: Remove unused value
Message-ID: <aJ6zKriNeoM4B/km@bhairav-test.ee.iitb.ac.in>
References: <20250814165403.616195-1-chandramohan.explore@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814165403.616195-1-chandramohan.explore@gmail.com>

On Thu, Aug 14, 2025 at 10:24:01PM +0530, Chandra Mohan Sundar wrote:
> The value "new" is being assigned to NULL but that statement does not
> have effect since "new" is being overwritten in the subsequent
> fallback case.
> 
> Remove the unused value. This issue was reported by coverity static
> analyzer.

Hi Chandra. Do you have Coverity ID for this issue ?

Regards,
Akhilesh
> 
> Fixes: a9eb185be84e9 ("apparmor: fix x_table_lookup when stacking is not the first entry")
> Signed-off-by: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
> ---
> Changes since v1:
>     Fixed the commit message and Fixes tag message formatting.
> 
>  security/apparmor/domain.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
> index 267da82afb14..9c0c7fa8de46 100644
> --- a/security/apparmor/domain.c
> +++ b/security/apparmor/domain.c
> @@ -592,7 +592,6 @@ static struct aa_label *x_to_label(struct aa_profile *profile,
>  		if (!new || **lookupname != '&')
>  			break;
>  		stack = new;
> -		new = NULL;
>  		fallthrough;	/* to X_NAME */
>  	case AA_X_NAME:
>  		if (xindex & AA_X_CHILD)
> -- 
> 2.43.0
> 
> 
