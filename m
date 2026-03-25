Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DDF3DF016
	for <linux-security-module@vger.kernel.org>; Wed, 25 Mar 2026 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774453012; cv=none; b=DwyKv7muE880QfPgz6/zRKZywkqiHdLhtB1ZeXSf/LFfB2pCqhztwff6oQiUlG5kr6IFe3T4AW8X7unlnYLoL5n7xNudUODxz8EQ0q+W8r6xHF3G1uEKVDniMl/Ip32Sx41sQwLYrZ9eLoNcdsdsMGQiXeSdOidZ5TrgbQcvwLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774453012; c=relaxed/simple;
	bh=VOmtj+Vf3f52V1rX+ihdafEh2DLxXnMgbqSE5D0l77I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIczYyBccLefTdMM4+ILeG1kMgjDmIHt8VCHmluTHWIM+I/OfC9TZfSL75FMfFChv9lqgvywITWRAxwYhMN8GLRFQGb2bteSbBi17cw9Otn7IUwKlElR1dVb7OerfRQEnQ4wxOKm8EEyz9JFgfwm8HrNwXVXFg5YDpTEyhGACAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=uRxDLoO1; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="uRxDLoO1"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fgrNM06GmzgZh;
	Wed, 25 Mar 2026 16:26:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1774452386;
	bh=SCtQYYirznlvk7zN2bBpQV25bhkPn863DXHkqrjvwq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uRxDLoO1B4xxoFEskeW9QkK4jq52v4pjzU1ue6Pf1+CI28JLax45yqcQSziDcNwOl
	 8O2+5rGD7RxcSd7PaWJ5JRW7GnT0QOITawK0UqB7iX6FiIrwN7HhydLzI84S50iWq7
	 Yhavb1x9N10J1YVobRPowKw92zGCGKdeCFgmjdxM=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fgrNL0pK4zHQk;
	Wed, 25 Mar 2026 16:26:26 +0100 (CET)
Date: Wed, 25 Mar 2026 16:26:22 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Justin Suess <utilityemal77@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 03/11] nsproxy: Add FOR_EACH_NS_TYPE() X-macro and
 CLONE_NS_ALL
Message-ID: <20260325.Mo5Lahthohng@digikod.net>
References: <20260312100444.2609563-1-mic@digikod.net>
 <20260312100444.2609563-4-mic@digikod.net>
 <20260325-utensil-endung-6e28806ae92c@brauner>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260325-utensil-endung-6e28806ae92c@brauner>
X-Infomaniak-Routing: alpha

On Wed, Mar 25, 2026 at 01:33:31PM +0100, Christian Brauner wrote:
> On Thu, Mar 12, 2026 at 11:04:36AM +0100, Mickaël Salaün wrote:
> > Introduce the FOR_EACH_NS_TYPE(X) macro as the single source of truth
> > for the set of (struct type, CLONE_NEW* flag) pairs that define Linux
> > namespace types.
> > 
> > Currently, the list of CLONE_NEW* flags is duplicated inline in
> > multiple call sites and would need another copy in each new consumer.
> > This makes it easy to miss one when a new namespace type is added.
> > 
> > Derive two things from the X-macro:
> > 
> > - CLONE_NS_ALL: Bitmask of all known CLONE_NEW* flags, usable as a
> >   validity mask or iteration bound.
> > 
> > - ns_common_type(): Rewritten to use the X-macro via a leading-comma
> >   _Generic pattern, so the struct-to-flag mapping stays in sync with the
> >   flag set automatically.
> > 
> > Replace the inline flag enumerations in copy_namespaces(),
> > unshare_nsproxy_namespaces(), check_setns_flags(), and
> > ksys_unshare() with CLONE_NS_ALL.
> > 
> > When a new namespace type is added, only FOR_EACH_NS_TYPE needs to
> > be updated; CLONE_NS_ALL, ns_common_type(), and all the call sites
> > pick up the change automatically.
> > 
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Günther Noack <gnoack@google.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> 
> Yeah, I love that. I can take that as a separate patch right now even.

Yes, please take it.

> 
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> 
