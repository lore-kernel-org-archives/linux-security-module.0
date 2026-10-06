Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03CF37C91E
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280639; cv=none; b=Uyt0rTgmaaJlPDDyLXRGZ7wGSXyaPWA8B+7KIaTyjAdgFpqDBKNswtoOLN3dzd8P7WGHIdPe+fIokPvTOSaDcGc3Xm9Vsu9R8yefhxHSUhIUKgIQHf9E398HvI59s4VcMrtd4CWI3DbGVKnOg8YQaiRmxUrVU1BVl/Z9mON0f98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280639; c=relaxed/simple;
	bh=YZQu7g3QBp9P4SUelfN9I3/NuwGuO8VwyhtRC4EnDNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XL+EVbD6TD8IhrDUezs3fBcIIq3A4ZMNUR2/Q8eIanfTjUKV1n26Du00RHFjq247B5O6MZkbW3ovV/0KxSU0Sl0u5EEgPWOj9bKOAM8YQyyGN6cQEt3XePFjJWSMhhTwl8h4cihNKld8unQ7v7j6o6Kl8nd1HEzQGF7Wb8jy0wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=AjDyibPm; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="AjDyibPm"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hzWrH6gp6znjl;
	Tue,  6 Oct 2026 11:57:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1791280623;
	bh=1EGI+kI25Q0djPAmscqTq4uRG7U5UWcApAaK3bBnxYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AjDyibPm+L1cLECcdRE//QhSnp4n49rK+V+gLT+VYMJDe+RLhwqJXQXnlFgBCpOEx
	 5wisJSR3iwnuUNJTWRQI04NqJ+xU7As75Asff+ZU4RbJd8jwiJsvsc6IN0eQcAWR8M
	 YHAiId21yEVh4vy/TZYJY0dTPIA1KjFK2GRzseK4=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hzWrH2WJ2zRPh;
	Tue,  6 Oct 2026 11:57:03 +0200 (CEST)
Date: Tue, 6 Oct 2026 11:56:59 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 5/8] selftests/landlock: Add namespace restriction
 tests
Message-ID: <20261006.tooshaPae6ai@digikod.net>
References: <20261002124409.1277970-1-mic@digikod.net>
 <20261002124409.1277970-6-mic@digikod.net>
 <20261002125628.94DE41F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261002125628.94DE41F00898@smtp.kernel.org>
X-Infomaniak-Routing: alpha

On Fri, Oct 02, 2026 at 12:56:28PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] selftests/landlock: Data truncation of 64-bit namespace flags in audit log string matching
> --
> 
> commit 5fd29f953c165adc6df65241e36e43cef7dbf0ae
> Author: Mickaël Salaün <mic@digikod.net>
> 
> selftests/landlock: Add namespace restriction tests
> 
> This commit adds extensive tests for the LANDLOCK_PERMISSION_NAMESPACE_USE
> restriction, covering namespace creation and entry. It includes rule
> validation, forward compatibility checks, layer stacking, and audit logging.
> 
> Link: https://patch.msgid.link/20260726161400.3010511-10-mic@digikod.net
> 
> > diff --git a/tools/testing/selftests/landlock/ns_test.c b/tools/testing/selftests/landlock/ns_test.c
> > new file mode 100644
> > index 0000000000000..6faafc110844d
> > --- /dev/null
> > +++ b/tools/testing/selftests/landlock/ns_test.c
> 
> [ ... ]
> 
> > +static int matches_log_ns_create(int audit_fd, __u64 ns_type)
> > +{
> > +	static const char log_template[] = REGEX_LANDLOCK_PREFIX
> > +		" blockers=namespace\\.use namespace_type=0x%x namespace_id=0$";
> > +	char log_match[sizeof(log_template) + 10];
> > +	int log_match_len;
> > +
> > +	log_match_len = snprintf(log_match, sizeof(log_match), log_template,
> > +				 (unsigned int)ns_type);
> 
> [Severity: Low]
> Does this format string risk truncating the ns_type value? The ns_type
> parameter is a 64-bit __u64, but it is explicitly cast to unsigned int
> and formatted with %x. If a namespace flag exceeding 32 bits is ever
> tested, the upper 32 bits will be truncated, producing an incorrect audit
> log match string and causing test failures.

The cast is intentional and doe snot truncate an emitted audit value
(which is 32-bit).

> 
> > +	if (log_match_len >= sizeof(log_match))
> > +		return -E2BIG;
> > +
> > +	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
> > +				  NULL);
> > +}
> > +
> > +static int matches_log_ns_setns(int audit_fd, __u64 ns_type, __u64 ns_id)
> > +{
> > +	static const char log_template[] = REGEX_LANDLOCK_PREFIX
> > +		" blockers=namespace\\.use namespace_type=0x%x namespace_id=%llu$";
> > +	char log_match[sizeof(log_template) + 32];
> > +	int log_match_len;
> > +
> > +	log_match_len = snprintf(log_match, sizeof(log_match), log_template,
> > +				 (unsigned int)ns_type,
> > +				 (unsigned long long)ns_id);
> 
> [Severity: Low]
> This seems to have the same truncation issue as matches_log_ns_create()
> above. The 64-bit ns_type parameter is cast to a 32-bit unsigned int and
> formatted with %x, which will drop the upper 32 bits.

No issue here as well.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261002124409.1277970-1-mic@digikod.net?part=5
> 
