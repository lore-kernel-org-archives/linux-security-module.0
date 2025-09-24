Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CDF2D63FC
	for <linux-security-module@vger.kernel.org>; Wed, 24 Sep 2025 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705662; cv=none; b=SHXaHu7dqSnVANkqdfCnHAk4MvCArp5HIEeWOxBh0lBJ4E2w1ESkUFrbgPMxqyhxv94ppHy6OFP9ATnt9q2ppcAqkzzuia4vSPsOhg2LlSLlqKXEkN+zPLy8CG3pG5qxY+/LBiDc2db6jghlWSu3gwpUo6HFJU4xYIqVxrKt7IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705662; c=relaxed/simple;
	bh=UCeDtJU19Bgc3v2VP3oVOGAp1deBtEDRsxUHGkGdDBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7XH8GCCMUt1U7DujrvQ3uFiiokms/lfFB8ejNJ6SnKexPTVDqxHWbMHJasan+62syyND2DYFbQmkfKX5VNVBPcWeDSto8sQpa0HdlDzjE0qpPD3YgMRmdyp+YXsawKcDOPDlJnjO+gI204Q9OV0KXLWQL3wWZwmt0/bCWsATrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=rSgIXz2o; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="rSgIXz2o"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cWrtN1gL4z6BL;
	Wed, 24 Sep 2025 11:20:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1758705644;
	bh=e6DWm3iIi7gHS+GnPs2o2D5JdAlccYXLEbUOlPzzGk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rSgIXz2onqeL7zASYfcz8OHd6MQgnFtGQ/fZurWANSVAXl11PIJddbkAaasIdZpmE
	 aBtP7I2Xc8XO5mOL/DmWM//fM7gugpjzTFEiNhbrocz4JEZSFLE9txmsYRuwYV85l1
	 4Z6sDpvgUt0OHYOXqSunyER2d5zlylVDcYDqXxls=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4cWrtM4c93zpFj;
	Wed, 24 Sep 2025 11:20:43 +0200 (CEST)
Date: Wed, 24 Sep 2025 11:20:42 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] landlock: Add a place for flags to layer rules
Message-ID: <20250924.wu8Ieku8aiph@digikod.net>
References: <cover.1757376311.git.m@maowtm.org>
 <841550c5d7bbc7ffcd74f85ee659caf1e29cff67.1757376311.git.m@maowtm.org>
 <20250919.oanahnoon2Za@digikod.net>
 <a43a9985-cf62-482b-9a2d-fce463ca69b0@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a43a9985-cf62-482b-9a2d-fce463ca69b0@maowtm.org>
X-Infomaniak-Routing: alpha

On Mon, Sep 22, 2025 at 12:52:19AM +0100, Tingmao Wang wrote:
> On 9/19/25 17:02, Mickaël Salaün wrote:
> > On Tue, Sep 09, 2025 at 01:06:35AM +0100, Tingmao Wang wrote:
> >> To avoid unnecessarily increasing the size of struct landlock_layer, we
> >> make the layer level a u8 and use the space to store the flags struct.
> >>
> >> Signed-off-by: Tingmao Wang <m@maowtm.org>
> >> ---
> >>  security/landlock/fs.c      | 75 ++++++++++++++++++++++++-------------
> >>  security/landlock/net.c     |  3 +-
> >>  security/landlock/ruleset.c |  9 ++++-
> >>  security/landlock/ruleset.h | 27 ++++++++++++-
> >>  4 files changed, 83 insertions(+), 31 deletions(-)
> >>
> >> [...]
> >> @@ -643,6 +644,12 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
> >>  		unsigned long access_bit;
> >>  		bool is_empty;
> >>  
> >> +		if (rule_flags) {
> >> +			/* Collect rule flags for each layer */
> >> +			if (layer->flags.quiet)
> >> +				rule_flags->quiet_masks |= layer_bit;
> > 
> > This patch makes quiet flags related to on object, but not tied to the
> > rule access rights (as explained in the next patch's doc). To tie it to
> > rule access rights would require to duplicate the access bits for each
> > rule (because multiple rules can be tied to the same object for the same
> > layer/ruleset).
> 
> (imo the use of "rule" here as a terminology is a bit confusing, I would
> have thought that a "rule" is a collection of access rights associated
> with an object, and therefore you can of course only have one rule per
> object in a ruleset.  Otherwise landlock_add_rule should really have been
> called landlock_add_rules...?)

A rule is indeed a set of access rights tied to an object.  However,
when the same object is used with two calls to landlock_add_rule(), the
ruleset's rule is the union of both access rights.

What I wanted to highlight is that the quiet flag is unrelated to the
access rights, which makes sense because the otherwise it would never be
denied and then never logged.

> 
> > 
> > So, the question is, what do we really need to mute?
> > 
> > I think the current approach is enough. We could still add a new flag in
> > the future, or maybe even a new field to each rule type.  However, we
> > should rename the flag to make it clear that the it's related to the
> > rule's object which is muted instead of the whole rule.  Maybe something
> > like LANDLOCK_ADD_RULE_QUIET_OBJECT?
> 
> I don't see what benefit a new field to each rule type would bring, since
> different rule types targets different objects and live in different
> rbtrees, and so they are already separable.

Adding a new field to rule types would allow to only mute denied
requests if they match an access right, instead of muting all
non-allowed access rights.  For instance, if an app tries to do an ioctl
because of legacy/compatibility reasons, we may want to ignore such
request, but we may still want to log malicious attempts to modify
regular files (in the same file hierarchy).

> 
> > 
> > If we want to have a more fine-grained control, a complementary patch
> > could add a bitfield for each access right type to quiet a denied access
> > right iff the object is also quiet (where rules are possible).  That
> > could be a follow up to complete this quiet feature, but this patch
> > series is good on its own.
> 
> Worth noting that if one really wants to suppress logging for only some
> access bits and we do not add support for it (due to the extra overhead
> etc), that is still doable with just this patch by using two layers - the

This hack should definitely not be encouraged, otherwise the limit of 16
layers will shrink to 8 (or less) in practice.

> outer one would contain the intended rules but not have any quiet flags,
> whereas the inner one would contain the same set of rules but with quiet
> flags set, except that for access bits which the sandbox does not want to
> be quiet, it would also "allow" them in the second layer (access would
> still be denied by the first layer, but would get audit logged due to
> quiet flag not applying when the younger layer allows the access).
> 
> But this gets very tricky in the context of mutable domains, and does not
> work at all for the purpose of controlling whether supervisor mode would
> delegate to the supervisor or deny outright, since supervisors are
> "accumulative".  Therefore if this (different "quietness" for different
> access bits) becomes a strong need, we should probably consider some way
> of implementing it, rather than expecting a sandboxer to do this two-layer

> hack.  (But implementing this does have the potential to result in needing
> to have a (number of access bits) x (number of layers) matrix...)

Yes, that will indeed increase the size of rules, which is why I'm not
sure if it worth it.

The alternative I was thinking about is to only increase the size of
struct landlock_ruleset (which would be negligible) to include sets of
quiet access rights.  A request to such access right *on* a quiet object
would never be logged.  I think this approach is flexible enough and
doesn't increase much the complexity.  This would also be useful to not
log access rights that don't have associated rules (e.g. scopes), and
then no identified objects.  To avoid the kind of hack you pointed out,
this feature should probably be part of this patch series though.  What
do you think?

> 
> > [...]
> 
> Will add suggested changes in v2.  Thanks for the review :)
> 
> Kind regards,
> Tingmao
> 
