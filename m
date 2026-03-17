Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BB726463A
	for <linux-security-module@vger.kernel.org>; Tue, 17 Mar 2026 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773774776; cv=none; b=C1nGjVN02PZTMz1DUGtMBk6Z5KFfBIGij5qFfMuwJEAu11nHHROWlwB1fiev7858VGMAIv553GFB9YyNEx8dy1tjjXu6GjSd059/VEvaYA6mvseoQ09CPsjXSDCo8vgNMe2TpMsrFMixCBK1BDMypW+8ZJtVEGTVLc38xjYLSKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773774776; c=relaxed/simple;
	bh=14g4c1egADHwKeqVn8hHwM7BQTnwBtVm/9I3jUL9c+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqnrUBXbuNP2/xWbegnVltHnSvWRibXwXKpOC3QAKeJuFQXlX5mycLAfxreT0VwBCcmxRHV0JzxHXVIkqswbEjMHgdWVj0HySP5JURsjCC6Yn9wzsY/j/QblXHmYdJSj9D1Mjg5p5z6p2ffjgAT5d2B+hxJc8hhd8w0sAYNkLCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Q80v1UmL; arc=none smtp.client-ip=84.16.66.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Q80v1UmL"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fb1n9066pzKP1;
	Tue, 17 Mar 2026 20:12:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773774764;
	bh=e27S21pa8oWOdNh+FUniIpYi398jcpMfObOxxdVgxVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q80v1UmL+zjUUo0GkfzQDy/oPFRSBve4UxTPa4Qe/Vr4NVcizvJhtZcSvm57UCsq4
	 oOD2Odm+/eU5k9yxRjLhZADIg4e6/Ib5HdQ2BfTKMs6ko9QqF5Drxg2XKh3SWTJwGj
	 vzafNeXVjoEWY4XeLxhb6KPAC22OVamsaXduHxp4=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fb1n81sJBzGYs;
	Tue, 17 Mar 2026 20:12:44 +0100 (CET)
Date: Tue, 17 Mar 2026 20:12:40 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: David Windsor <dwindsor@gmail.com>
Cc: fred@cloudflare.com, paul@paul-moore.com, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, kpsingh@kernel.org
Subject: Re: [PATCH RFC 1/4] audit: Implement bpf_audit_log_*() wrappers
Message-ID: <20260317.maoD7thah7pi@digikod.net>
References: <20260311-bpf-auditd-send-message-v1-1-10a62db5c92f@cloudflare.com>
 <20260316221440.2043299-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316221440.2043299-1-dwindsor@gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Mar 16, 2026 at 06:14:40PM -0400, David Windsor wrote:
> Hi Frederick,
> 
> On Wed, Mar 11, 2026 at 04:31:17PM -0500, Frederick Lawler wrote:
> > +__bpf_kfunc int bpf_audit_log_cause(struct bpf_audit_context *ac,
> > +				    const char *cause__str)
> > +{
> > +	if (log_once(ac, BIT_ULL(LSM_AUDIT_DATA_CAUSE)))
> > +		return -EINVAL;
> > +
> > +	audit_log_format(ac->ab, " cause=");
> > +	audit_log_untrustedstring(ac->ab, cause__str);
> > +	return 0;
> > +}
> 
> Rather than putting everything in the cause field, could we perhaps
> have a separate kfunc here that appends normal stringpairs (not
> format strings) to the audit record:
> 
>   bpf_audit_log_str(ac, "result", "denied");
>   bpf_audit_log_str(ac, "op", "read");
>   bpf_audit_log_str(ac, "scontext", ctx_str);

That would mean arbitrary audit keys (and values), which would not be
acceptable (i.e. no consistency).

> 
> I know you didn't want to wrap audit_log_format(), which makes sense,
> this would be a midway point between that and stuffing everything in
> one field.
