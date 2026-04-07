Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A68338B138
	for <linux-security-module@vger.kernel.org>; Tue,  7 Apr 2026 07:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775547051; cv=none; b=Ewyr+fF7wDM+1lrGBqgMuwDOPNfv3zxgd79MRgqlMiYApR+s7e6/Yk2OSzJWevV2me0TnNS+gbmiae/3L+gK+lWVyY+ieLrJEGeG0YsawmMvhbdB9RZCm9bFRLy9DtOdgDrzLnAjUQv9j3jEByK0LttWMKgs5JBiaz1ZusgLVbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775547051; c=relaxed/simple;
	bh=E5y3k0mXPzH/qxF0YXQt/DX16DB+M6XnhTappRzq0Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jks6bqrB9TxAbnC+S2sWiDmWvc67d1z9O+SucUPRyiS7qOks+unBhaQO/6QPMggVN8nofwo/dkB/kYrzIL4Z4x0UIJGvklPSaHZ8GDyuYBmfai20XTFnhkC3Pocg7T9h6e8UQDe3RojnzYtKt3j3ppAl4IXLjWZ2KECIrw57Kww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyQpwHU2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyQpwHU2"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a29e6110so26907615e9.3
        for <linux-security-module@vger.kernel.org>; Tue, 07 Apr 2026 00:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775547048; x=1776151848; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jTmaz406rgb4TnsgCDoTRBShvc8OZfMO2qi0BTEdttE=;
        b=TyQpwHU2KH1lemNw0511fliyChdjeUH0wBAbbDX1ioxb0IMazfX9LTcOyMNSS8SIPA
         OI0zAz0MglLgLv03XO8nRNpNtYHgqvOXOMD3v7PF0COy3FW0fkKi3znl/XuemzvV75/P
         IuTuC069EQnCwzogCl8QJkVUQ9jEcmb+UgmRyE7E1LEodMjNny7WWod1ihMPfKXnz5ns
         20gqDuvak62CQ8cGRvycp6FohKG0ltWfQuKoBJFsnXUHBe3OZvmSPJ+IcqainPy0BZzA
         9XGz/IJLwXLTBfBcreR44MWb6U6Vf8j8dPzB0Pn9zwmjnwIR920RFJ6jbDi/rLFOQDgD
         okGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775547048; x=1776151848;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jTmaz406rgb4TnsgCDoTRBShvc8OZfMO2qi0BTEdttE=;
        b=mTUss6SRG3YC2NgreAYeIWjP/zl3gFr/6NL6wmZFZ6aJBoxMUADRNFC3QTBzqOQ6wb
         aqzI333plgNWS+J1GdtH9YMSnU4jy2P/rAQLfP77oPopCmFDKvJyb3PzMb0gZVveucEa
         nd5WkYcl7n3XQIwh4AGc2Jkc5TdEl8pGL0eth7MZrPWGy93G9ul36BQ/2BPtf3peDXDm
         nxFSSNv8oZgn74XpJyzC6tsHOyJyxhkWJt30aGxZ2BXXnzXqmwwxA+as4bwacI7HuyHt
         HQpqYvaWnUuIgINRhYyKm2EB6Nr92j9CnxIH/ZDwsIDW6DtXhQ+2mJ1MAObdL0Gz/gjg
         XPQw==
X-Forwarded-Encrypted: i=1; AJvYcCXjFS3hWqB88rZWN8ikLF/g+DWjbxugY0C1JbRj9EfsPuJbH7FedEYgaHZoq+ysjD21WRJbbcOm66aMvJ7MUJmCDPI1rGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjAUz63ohNGx/xbjF2WvYcoX6RcfaNvO4OxBPJ5DPQ7owmDcuH
	vGgp2WeA7PfXyF44eOWkVwbg54FWp69EYyjryJ+nQXb+OTp2JVWgNc5m
X-Gm-Gg: AeBDieuB4ouGDs1V8/pp7FeutTwknenaBaqXB2DqI3LZ5K/VTlJ7zA6uWk4R/Wm9j7R
	+QmdMSMdEIwItQqgV6CiA1uzv8BSkTbJsS7YKLHCxqB9ZlOhpmhzjohqO646IkxP+0/WpK31Hjv
	U5qAjCXAYfIPC+2BvMeYqtW4ZOZiDtrLCJhssRipavJE6GAQLxdSffdrzKgXgsFDznDpATtqBMf
	Nw2+imvJ6TXYwvpd1jFHWgiscLKAGwqOghQeJV5LrENCgku1E2r0s8vKUu4F19l9EN2vjUe25eq
	ZZ7oeFR3QBg5TGAmnS1t4s5kcPJdOZFlUCCeFDwTL8XcuhlqbxMtsbpk8o+AJBsNVoZqiIc/etj
	3TKEDe+d0JRCg1+QssUSxjgKGrLu5dUuOVuVWWAOKcKZcfi8e0m08YtwXB763MKb1/a0E4SgEn7
	jXJdJrz6h0Ajnf/bXxjG37C2T3nTNa+8pZ3i0MPXllajeptZy7
X-Received: by 2002:a05:600c:138f:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-4889970e3c4mr215358595e9.11.1775547047220;
        Tue, 07 Apr 2026 00:30:47 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4889f6843dfsm330139725e9.12.2026.04.07.00.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 00:30:46 -0700 (PDT)
Date: Tue, 7 Apr 2026 09:30:40 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] landlock: Fix log_subdomains_off inheritance
 across fork()
Message-ID: <20260407.844e42deb531@gnoack.org>
References: <20260404085001.1604405-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260404085001.1604405-1-mic@digikod.net>

Hello!

On Sat, Apr 04, 2026 at 10:49:57AM +0200, Mickaël Salaün wrote:
> hook_cred_transfer() only copies the Landlock security blob when the
> source credential has a domain.  This is inconsistent with
> landlock_restrict_self() which can set log_subdomains_off on a
> credential without creating a domain (via the ruleset_fd=-1 path): the
> field is committed but not preserved across fork() because the child's
> prepare_creds() calls hook_cred_transfer() which skips the copy when
> domain is NULL.
> 
> This breaks the documented use case where a process mutes subdomain logs
> before forking sandboxed children: the children lose the muting and
> their domains produce unexpected audit records.
> 
> Fix this by unconditionally copying the Landlock credential blob.
> landlock_get_ruleset(NULL) is already a safe no-op.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: stable@vger.kernel.org
> Fixes: ead9079f7569 ("landlock: Add LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/landlock/cred.c                      |  6 +-
>  tools/testing/selftests/landlock/audit_test.c | 88 +++++++++++++++++++
>  2 files changed, 90 insertions(+), 4 deletions(-)
> 
> diff --git a/security/landlock/cred.c b/security/landlock/cred.c
> index 0cb3edde4d18..cc419de75cd6 100644
> --- a/security/landlock/cred.c
> +++ b/security/landlock/cred.c
> @@ -22,10 +22,8 @@ static void hook_cred_transfer(struct cred *const new,
>  	const struct landlock_cred_security *const old_llcred =
>  		landlock_cred(old);
>  
> -	if (old_llcred->domain) {
> -		landlock_get_ruleset(old_llcred->domain);
> -		*landlock_cred(new) = *old_llcred;
> -	}
> +	landlock_get_ruleset(old_llcred->domain);
> +	*landlock_cred(new) = *old_llcred;

This fix looks correct for the hook_cred_prepare() case (and of
course, hook_cred_prepare() calls hook_cred_transfer() in Landlock).


But I'm afraid I might have spotted another issue here:

If I look at the code in security/keys/process_keys.c, where
security_tranfer_creds() is called, the "old" object is actually
already initialized, and if we are not checking for that, I think we
are leaking memory.

I would suggest to use the helper landlock_cred_copy() from cred.h for
that.  This one is anyway supposed to be the central place for this
copying logic, and it is safe to use with zeroed-out target objects
(because the put is safe for the NULL-pointer).

Maybe this is worth updating while we are at it?


>  }
>  
>  static int hook_cred_prepare(struct cred *const new,
> diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
> index 46d02d49835a..20099b8667e7 100644
> --- a/tools/testing/selftests/landlock/audit_test.c
> +++ b/tools/testing/selftests/landlock/audit_test.c
> @@ -279,6 +279,94 @@ TEST_F(audit, thread)
>  				&audit_tv_default, sizeof(audit_tv_default)));
>  }
>  
> +/*
> + * Verifies that log_subdomains_off set via the ruleset_fd=-1 path (without
> + * creating a domain) is inherited by children across fork().  This exercises
> + * the hook_cred_transfer() fix: the Landlock credential blob must be copied
> + * even when the source credential has no domain.
> + *
> + * Phase 1 (baseline): a child without muting creates a domain and triggers a
> + * denial that IS logged.
> + *
> + * Phase 2 (after muting): the parent mutes subdomain logs, forks another child
> + * who creates a domain and triggers a denial that is NOT logged.
> + */
> +TEST_F(audit, log_subdomains_off_fork)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr = {
> +		.scoped = LANDLOCK_SCOPE_SIGNAL,
> +	};
> +	struct audit_records records;
> +	int ruleset_fd, status;
> +	pid_t child;
> +
> +	ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
> +
> +	/*
> +	 * Phase 1: forks a child that creates a domain and triggers a denial
> +	 * before any muting.  This proves the audit path works.
> +	 */
> +	child = fork();
> +	ASSERT_LE(0, child);
> +	if (child == 0) {
> +		ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
> +		ASSERT_EQ(-1, kill(getppid(), 0));
> +		ASSERT_EQ(EPERM, errno);
> +		_exit(0);
> +		return;
> +	}
> +
> +	ASSERT_EQ(child, waitpid(child, &status, 0));
> +	ASSERT_EQ(true, WIFEXITED(status));
> +	ASSERT_EQ(0, WEXITSTATUS(status));
> +
> +	/* The denial must be logged (baseline). */
> +	EXPECT_EQ(0, matches_log_signal(_metadata, self->audit_fd, getpid(),
> +					NULL));
> +
> +	/* Drains any remaining records (e.g. domain allocation). */
> +	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
> +
> +	/*
> +	 * Mutes subdomain logs without creating a domain.  The parent's
> +	 * credential has domain=NULL and log_subdomains_off=1.
> +	 */
> +	ASSERT_EQ(0, landlock_restrict_self(
> +			     -1, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
> +
> +	/*
> +	 * Phase 2: forks a child that creates a domain and triggers a denial.
> +	 * Because log_subdomains_off was inherited via fork(), the child's
> +	 * domain has log_status=LANDLOCK_LOG_DISABLED.
> +	 */
> +	child = fork();
> +	ASSERT_LE(0, child);
> +	if (child == 0) {
> +		ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
> +		ASSERT_EQ(-1, kill(getppid(), 0));
> +		ASSERT_EQ(EPERM, errno);
> +		_exit(0);
> +		return;
> +	}
> +
> +	ASSERT_EQ(child, waitpid(child, &status, 0));
> +	ASSERT_EQ(true, WIFEXITED(status));
> +	ASSERT_EQ(0, WEXITSTATUS(status));
> +
> +	/* No denial record should appear. */
> +	EXPECT_EQ(-EAGAIN, matches_log_signal(_metadata, self->audit_fd,
> +					      getpid(), NULL));
> +
> +	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
> +	EXPECT_EQ(0, records.access);
> +
> +	EXPECT_EQ(0, close(ruleset_fd));
> +}
> +
>  FIXTURE(audit_flags)
>  {
>  	struct audit_filter audit_filter;
> -- 
> 2.53.0
> 

Test looks fine.

While I do still think we should investigate the memory leak, this
commit is, as it is, already a strict improvement over what we had
before, so:

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

–Günther
