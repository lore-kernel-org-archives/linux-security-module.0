Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793189935;
	b=jrfr0nqCWgDvitif4yYUR2LjFnwVxmcratWUmeSS33idLdUsVRSXOGs59VYRIMZENrJe
	 ErwajPSpBvpPgtcXEn3+XhvKB4vg9dtb5+qYO7jNfhTQdck7C8CemCqODDvwA6Wf7tW3o
	 Jl1EsEtdDRPxf1P2hBr/0MkxtiEMMvHmkvoJg627FIRjnf0Fe/CIND6rK/cODL5MTosDv
	 YVx9nZIVXh+lPrfGOL9/a9UDxauQnuNjOoO4pQEoUah1JZSMJwouWCFseUA6+D3ZFKtVr
	 0dpS0R4zHwKOCWz3zwDWST8nS/1qic++Ibiv+v2g+A1iv4+MHSGRXaq+76uu0ihhVEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793189935;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=OskEvaxrgfNfL/Gq5v8g3VeZhJ7zUOHQB1CES574JS0=;
	b=grhouGRvmEjU7iJQGeHspzUrPsFmFffvGj0Pm8a2gSKZu8HupLXig3RuT6GywBkELM/h
	 A527WKLANdnqmdx0WRUekaYtXmF9Ti6kX2OflNQF0M4zSwMKHAg50EgzMcGWmEuP2co2c
	 qQKEVme3rRf913PvlhTHwWvsKeCD+0WEcAzdTkHYg0Pci14uyz6hujC4CnStuseK1AI5U
	 l9g6ia9URIHMMvSva5zo2sW45OVxplZwtklqKy+PBug0SIv6bWJVuMMEjBQZg/QPDHUFS
	 G9iZ4iqjnZwLCRLws+VcNRjmzy/89tv20EsuQ/YhSLDBwAdbC/HnkwInTsIjNfXk+PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="gXfA/Dfp";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ihTRBDUo;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="z8DqKq/+";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HgutpAPI;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F272606A32F;
	Wed, 28 Oct 2026 12:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F272606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gXfA/Dfp;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ihTRBDUo;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=z8DqKq/+;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HgutpAPI
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DB2AB2212C;
	Wed, 28 Oct 2026 12:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793189927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OskEvaxrgfNfL/Gq5v8g3VeZhJ7zUOHQB1CES574JS0=;
	b=gXfA/DfpF6w+jyZaWtiR86xpjyK4cUM01VKUq3ddfeV01r2x5BlhIoEm39ldSPFMxwckRQ
	/Fy4Ng+MwGEDmhprV1iwEcx53S2e1sfnTLx8rptIWu4ZkVfpJ/dOaVgJHrCrKQZaHAExFC
	lesktXcN/bRaF6rQoWKMbvwZakHJ8DE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793189927;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OskEvaxrgfNfL/Gq5v8g3VeZhJ7zUOHQB1CES574JS0=;
	b=ihTRBDUoHkkC1CO9Vi7stz2y/cMF7dsbcqqppFqULwrhtZd80WfubWLOKDDczOMOfPN7UP
	tMqLffewEcxRxUAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="z8DqKq/+";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HgutpAPI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793189926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OskEvaxrgfNfL/Gq5v8g3VeZhJ7zUOHQB1CES574JS0=;
	b=z8DqKq/+TGAIJwmTF4U0sQ7FfYKJ77L7dKL/trqLyzIl/Sgl9Ekctzsh1xn4HTwg+/cd4o
	R0xm4n8RpjQrRepUKjnrNa/qi2quvDzjKwWyo8+erMWnL1P2DO5b4tyYhdhl+EHyi1fk2X
	55OxWOhPLgi8dZ8SLybC4j9oDNf4bMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793189926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OskEvaxrgfNfL/Gq5v8g3VeZhJ7zUOHQB1CES574JS0=;
	b=HgutpAPIGu/bYSfZI0OSy/iDcOHIXFbgI+oIOVqCmUwY1MYJLVJuYZ33vVQG/DQK6vAmu9
	ASr5yKE/0sTjYkBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 399C71321C;
	Wed, 28 Oct 2026 12:18:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3uAeNSTo4WqLbwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 28 Oct 2026 12:18:45 +0000
Date: Wed, 28 Oct 2026 12:18:43 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	David Hildenbrand <david@kernel.org>, Kees Cook <kees@kernel.org>, Jeff Xu <jeffxu@chromium.org>, 
	Andrey Vagin <avagin@gmail.com>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/3] mseal sysmap: Add mseal_system_mappings= boot
 parameter
Message-ID: <auHkLMb_Xo-7Z7mx@pedro-suse.tail5790ac.ts.net>
References: <cover.1793094611.git.chris@chrisdown.name>
 <5bd3c89d733ad22224f296dfa8900769de937de0.1793094611.git.chris@chrisdown.name>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bd3c89d733ad22224f296dfa8900769de937de0.1793094611.git.chris@chrisdown.name>
X-Rspamd-Queue-Id: DB2AB2212C
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,infradead.org,kernel.org,google.com,chromium.org,gmail.com,mihalicyn.com,paul-moore.com,namei.org,hallyn.com,lwn.net,kvack.org,vger.kernel.org,meta.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.51

On Tue, Oct 27, 2026 at 07:43:04PM +0800, Chris Down wrote:
> CONFIG_MSEAL_SYSTEM_MAPPINGS seals each process' system mappings when
> they are created. As it is today this can only be toggled at build time,
> so hosts that need sealing and hosts running software which moves or
> unmaps these mappings end up with separate kernels. This is not ideal
> since it adds more complexity of deployment, it would be great to be
> able to have one kernel which can configurably do both.
> 
> So, to improve this, let's add mseal_system_mappings= so that this can
> be chosen at boot.

I'm very curious, do you actually have a usecase for this?

-- 
Pedro
