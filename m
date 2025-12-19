Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E692B329E7D
	for <linux-security-module@vger.kernel.org>; Fri, 19 Dec 2025 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766154469; cv=none; b=GmfZVvKXic1rDKO5BTewflkcUiOPqR69Nj8jxSBNj9QAK1Nc+RxoW6FLp/IF2hnCAP0tIASiB1WUkCG3hAl/NK2+TGIcwlv2/0659Sin7JSh6ES2lSm5lSTiOwWo8/h8zQJO0jtecG3sxUQUkFgbb7mEYLYRgK+24g9N/wumgpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766154469; c=relaxed/simple;
	bh=ZM1424Grq3OzxuuOTPQUXWBunN4J0Iei8q+htzHWggw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/Wctyf3qWiuEVIeyo7Y0vAw2fB5ylPayZLgiFut3RBzGL55vrwuD49BKomkeMh4agH3XppWKsS8yNGUh9yghwPiUKadnRW8MI5DPGljkjIvlF+ZIytSnW+uN52JptwNo/V8EEQShktfmZLjiKB3ZAz7o89kqkuYa9Zo0vxAxWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=q8/OBU58; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="q8/OBU58"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dXqcn1cjYzD08;
	Fri, 19 Dec 2025 15:27:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1766154457;
	bh=tfcNBwT+Sym7uuILbYQhiVkbHrSJsbZ42Q2IlvSp2K4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q8/OBU582pJ39WsxnCPl3NfzLP9b2Tj+ulfVr3oNZea5A331fV4fyUoeZa5JcrOo8
	 Qv08E2eKRXbcSftruWWeDn4vueId8CGpQYaW1EnOB/g6AIXatru7l6a076krHjrxSv
	 ySycc5XI9kRjexJugeefb0fDwyK+TsKtf1lC9S1g=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dXqcm4xfpzBNl;
	Fri, 19 Dec 2025 15:27:36 +0100 (CET)
Date: Fri, 19 Dec 2025 15:27:35 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Justin Suess <utilityemal77@gmail.com>, Jan Kara <jack@suse.cz>, Abhinav Saxena <xandfury@gmail.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 03/10] landlock: Suppress logging when quiet flag is
 present
Message-ID: <20251219.ahn3aiJuKahb@digikod.net>
References: <cover.1763330228.git.m@maowtm.org>
 <5c0de8ee7e00aff1aceb3a80f5af162eeaaa06db.1763330228.git.m@maowtm.org>
 <20251120.eoghapeeGh7i@digikod.net>
 <eb86863b-53b0-460b-b223-84dd31d765b9@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb86863b-53b0-460b-b223-84dd31d765b9@maowtm.org>
X-Infomaniak-Routing: alpha

On Sun, Nov 23, 2025 at 09:01:47PM +0000, Tingmao Wang wrote:
> On 11/21/25 15:27, Mickaël Salaün wrote:
> > On Sun, Nov 16, 2025 at 09:59:33PM +0000, Tingmao Wang wrote:
> >> [...]

> >>  /**
> >>   * landlock_log_denial - Create audit records related to a denial
> >>   *
> >>   * @subject: The Landlock subject's credential denying an action.
> >>   * @request: Detail of the user space request.
> >> + * @rule_flags: The flags for the matched rule, or no_rule_flags (zero) if
> >> + * this is a scope request (no particular object involved).
> >>   */
> >>  void landlock_log_denial(const struct landlock_cred_security *const subject,
> >> -			 const struct landlock_request *const request)
> >> +			 const struct landlock_request *const request,
> >> +			 const struct collected_rule_flags rule_flags)
> >
> > It would be simpler and limit code change to move rule_flags/quiet_flags
> > into struct landlock_request, which means we can also remove
> > no_rule_flags.
> 
> That's true, I can do that.  In fact this way we also don't have to have 2
> extra parameters for is_access_to_paths_allowed - it can just operate on
> log_request_parent{1,2}->rule_flags.  However I do see that
> landlock_request is intended to only be used by audit/logging code (and
> there is a comment in audit.h about not using it outside CONFIG_AUDIT to
> enable it to be optimized away, although testing a fresh build on next it
> doesn't look like it is taken out of vmlinux if compiled without
> CONFIG_AUDIT).

The log_request_parent* are indeed not elided.  I sent a patch to fix
that: https://lore.kernel.org/r/20251219142302.744917-2-mic@digikod.net


> While this is fine for the purpose of this series as the
> quiet flag only affects audit logging, I wonder if this might cause a
> problem when we want to add more flags that might not be related to audit
> (e.g. Justin's LANDLOCK_ADD_RULE_NO_INHERIT).
> 
> Alternatively maybe is_access_to_paths_allowed can still take extra
> parameters for rule flags, and we can make it so that the new rule_flags
> field in landlock_request is only assigned to right before
> landlock_log_denial, not from is_access_to_paths_allowed?  (I won't do
> this for v5 which I will send in a minute)

Yes, we should store the rule flags in landlock_request struct when this
in only required for audit.  In any case, we should always be able to
build without CONFIG_AUDIT, and in this case the stack frame should not
include landlock_request.  So in your last patch series, because
landlock_request's rule flags are referenced by standalone pointers,
landlock_requset cannot be elided.

> 
> >
> >>  {
> >>  	struct audit_buffer *ab;
> >>  	struct landlock_hierarchy *youngest_denied;
> >>  	size_t youngest_layer;
> >> -	access_mask_t missing;
> >> +	access_mask_t missing, quiet_mask;
> >> +	bool object_quiet_flag = false, quiet_applicable_to_access = false;
> >>
> >>  	if (WARN_ON_ONCE(!subject || !subject->domain ||
> >>  			 !subject->domain->hierarchy || !request))
> >> @@ -409,10 +586,13 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
> >>  			youngest_layer = get_denied_layer(
> >>  				subject->domain, &missing, request->layer_masks,
> >>  				request->layer_masks_size);
> >> +			object_quiet_flag = !!(rule_flags.quiet_masks & BIT(youngest_layer));
> >>  		} else {
> >>  			youngest_layer = get_layer_from_deny_masks(
> >>  				&missing, request->all_existing_optional_access,
> >> -				request->deny_masks);
> >> +				request->deny_masks,
> >> +				request->quiet_optional_accesses,
> >> +				&object_quiet_flag);
> >>  		}
> >>  		youngest_denied =
> >>  			get_hierarchy(subject->domain, youngest_layer);
