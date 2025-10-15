Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DB21F4CB7
	for <linux-security-module@vger.kernel.org>; Wed, 15 Oct 2025 19:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760555364; cv=none; b=nII3V59gdDp2zUttJWR78U65zz3dvaHE5QvLA86jOmfvoCFOH90WcvuLGr2OmzylXpIg7rL/ZVEU3YKItoWlt2wYjqZ349512gQh7i0i3otFPhg3Pow6X5asEnjTSlhjF7JhY6faIEDPrSzII7KoAwsGqC7w2OC90Rw74uu6kDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760555364; c=relaxed/simple;
	bh=ozr7UZ1IYw0I36SSXPPpEkMWJMIJUJJfKoZeukuccls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCDL1D90TsJ2uH9HgyzSEbSrt8YV3RhL+SZdiRIOGLwwhMTbBhH24dVCMhMX+1b20bihOdt7vqRM9Qp4VXsmhtp9zwGc9tmVG814KOn9hAMVu8ONhxh8bOFDSDMPzmWit7UGBIQq/YwJmG9yOCxqbaaWf4U6xlmbc6geKVtAID8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=mQnGNlRJ; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="mQnGNlRJ"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cn0xn6vqJzQxS;
	Wed, 15 Oct 2025 21:09:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1760555357;
	bh=YneHlHElxbWE4+WSWia6dA9tM3Ix/n9wHWpKJ0kX5oY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mQnGNlRJJ9pZm0x1PuqPm93CrF1Aaq0jPfOYP2AlE4rimKHvVAm92vRz4gGanbSUS
	 xlrr9kaMbBx1aa4dDxAxUb3nrRXh/nDXvdAcXpcqmSI8yRj/XD7gBjbTzDHngvK2uw
	 ezzKRts8OCPfFQYsxaIDFGtP/bbsxj1fEASYTIj8=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4cn0xn3XLdzTT8;
	Wed, 15 Oct 2025 21:09:17 +0200 (CEST)
Date: Wed, 15 Oct 2025 21:09:16 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 3/6] landlock/audit: Check for quiet flag in
 landlock_log_denial
Message-ID: <20251015.Iengoh1eeT0c@digikod.net>
References: <cover.1759686613.git.m@maowtm.org>
 <730434d416100f6a72b12fb31eb7253bc8b6fcc0.1759686613.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <730434d416100f6a72b12fb31eb7253bc8b6fcc0.1759686613.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

Just use "landlock: " as subject prefix.

On Sun, Oct 05, 2025 at 06:55:26PM +0100, Tingmao Wang wrote:
> Suppresses logging if the flag is effective on the youngest layer.
> 
> This does not handle optional access logging yet - to do that correctly we
> will need to expand deny_masks to support representing "don't log
> anything" in a later commit.
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
> 
> Changes since v1:
> - Supports the new quiet access masks.
> - Support quieting scope requests (but not ptrace and attempted mounting
>   for now)
> 
>  security/landlock/audit.c   | 70 +++++++++++++++++++++++++++++++++++--
>  security/landlock/audit.h   |  3 +-
>  security/landlock/fs.c      | 18 +++++-----
>  security/landlock/net.c     |  3 +-
>  security/landlock/ruleset.h |  5 +++
>  security/landlock/task.c    | 12 +++----
>  6 files changed, 92 insertions(+), 19 deletions(-)
> 
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index c52d079cdb77..ec00b7dd00c5 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -381,19 +381,39 @@ static bool is_valid_request(const struct landlock_request *const request)
>  	return true;
>  }
>  
> +static access_mask_t
> +pick_access_mask_for_req_type(const enum landlock_request_type type,

pick_access_mask_for_request_type

> +			      const struct access_masks access_masks)
> +{
> +	switch (type) {
> +	case LANDLOCK_REQUEST_FS_ACCESS:
> +		return access_masks.fs;
> +	case LANDLOCK_REQUEST_NET_ACCESS:
> +		return access_masks.net;
> +	default:
> +		WARN_ONCE(1, "Invalid request type %d passed to %s", type,
> +			  __func__);
> +		return 0;
> +	}
> +}
> +
>  /**
>   * landlock_log_denial - Create audit records related to a denial
>   *
>   * @subject: The Landlock subject's credential denying an action.
>   * @request: Detail of the user space request.
> + * @rule_flags: The flags for the matched rule, or no_rule_flags (zero) if
> + * this is a scope request (no particular object involved).
>   */
>  void landlock_log_denial(const struct landlock_cred_security *const subject,
> -			 const struct landlock_request *const request)
> +			 const struct landlock_request *const request,
> +			 const struct collected_rule_flags rule_flags)
>  {
>  	struct audit_buffer *ab;
>  	struct landlock_hierarchy *youngest_denied;
>  	size_t youngest_layer;
> -	access_mask_t missing;
> +	access_mask_t missing, quiet_mask;
> +	bool quiet_flag_on_rule = false, quiet_applicable_to_access = false;
>  
>  	if (WARN_ON_ONCE(!subject || !subject->domain ||
>  			 !subject->domain->hierarchy || !request))
> @@ -436,6 +456,52 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
>  	if (!audit_enabled)
>  		return;
>  
> +	/*
> +	 * Checks if the object is marked quiet by the layer that denied the
> +	 * request.  If it's a different layer that marked it as quiet, but
> +	 * that layer is not the one that denied the request, we should still
> +	 * audit log the denial.
> +	 */
> +	quiet_flag_on_rule = !!(rule_flags.quiet_masks & BIT(youngest_layer));
> +
> +	if (quiet_flag_on_rule) {
> +		/*
> +		 * This is not a scope request, since rule_flags is not zero.  We
> +		 * now check if the denied requests are all covered by the layer's
> +		 * quiet access bits.
> +		 */
> +		quiet_mask = pick_access_mask_for_req_type(
> +			request->type, youngest_denied->quiet_masks);
> +		quiet_applicable_to_access = (quiet_mask & missing) == missing;
> +
> +		if (quiet_applicable_to_access)
> +			return;
> +	} else {
> +		quiet_mask = youngest_denied->quiet_masks.scope;
> +		switch (request->type) {
> +		case LANDLOCK_REQUEST_SCOPE_SIGNAL:
> +			quiet_applicable_to_access =
> +				!!(quiet_mask & LANDLOCK_SCOPE_SIGNAL);
> +			break;
> +		case LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET:
> +			quiet_applicable_to_access =
> +				!!(quiet_mask &
> +				   LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
> +			break;
> +		/*
> +		 * Leave LANDLOCK_REQUEST_PTRACE and
> +		 * LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY unhandled for now - they are
> +		 * never quiet
> +		 */

This also covers the case where the object is not quiet.

> +		default:
> +			break;
> +		}

I find this if/else block a bit verbose but I didn't find a better
way...

> +
> +		if (quiet_applicable_to_access) {
> +			return;
> +		}

We can still move this quiet_applicable_to_access check after the block
(and without the curly braces).

> +	}
> +
>  	/* Checks if the current exec was restricting itself. */
>  	if (subject->domain_exec & BIT(youngest_layer)) {
>  		/* Ignores denials for the same execution. */

This domain_exec block would be better before the quiet_flag_on_rule
use.

> diff --git a/security/landlock/audit.h b/security/landlock/audit.h
> index 92428b7fc4d8..80cf085465e3 100644
> --- a/security/landlock/audit.h
> +++ b/security/landlock/audit.h
> @@ -56,7 +56,8 @@ struct landlock_request {
>  void landlock_log_drop_domain(const struct landlock_hierarchy *const hierarchy);
>  
>  void landlock_log_denial(const struct landlock_cred_security *const subject,
> -			 const struct landlock_request *const request);
> +			 const struct landlock_request *const request,
> +			 const struct collected_rule_flags rule_flags);
>  
>  #else /* CONFIG_AUDIT */
>  
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index b566ae498df5..1ccef1c2959f 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -984,7 +984,7 @@ static int current_check_access_path(const struct path *const path,
>  				       NULL, 0, NULL, NULL, NULL, NULL))
>  		return 0;
>  
> -	landlock_log_denial(subject, &request);
> +	landlock_log_denial(subject, &request, rule_flags);
>  	return -EACCES;
>  }
>  
> @@ -1194,7 +1194,7 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>  			    &request1, NULL, 0, NULL, NULL, NULL, NULL))
>  			return 0;
>  
> -		landlock_log_denial(subject, &request1);
> +		landlock_log_denial(subject, &request1, rule_flags_parent1);
>  		return -EACCES;
>  	}
>  
> @@ -1243,11 +1243,11 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>  
>  	if (request1.access) {
>  		request1.audit.u.path.dentry = old_parent;
> -		landlock_log_denial(subject, &request1);
> +		landlock_log_denial(subject, &request1, rule_flags_parent1);
>  	}
>  	if (request2.access) {
>  		request2.audit.u.path.dentry = new_dir->dentry;
> -		landlock_log_denial(subject, &request2);
> +		landlock_log_denial(subject, &request2, rule_flags_parent2);
>  	}
>  
>  	/*
> @@ -1403,7 +1403,7 @@ log_fs_change_topology_path(const struct landlock_cred_security *const subject,
>  			.u.path = *path,
>  		},
>  		.layer_plus_one = handle_layer + 1,
> -	});
> +	}, no_rule_flags);
>  }
>  
>  static void log_fs_change_topology_dentry(
> @@ -1417,7 +1417,7 @@ static void log_fs_change_topology_dentry(
>  			.u.dentry = dentry,
>  		},
>  		.layer_plus_one = handle_layer + 1,
> -	});
> +	}, no_rule_flags);
>  }
>  
>  /*
> @@ -1705,7 +1705,7 @@ static int hook_file_open(struct file *const file)
>  
>  	/* Sets access to reflect the actual request. */
>  	request.access = open_access_request;
> -	landlock_log_denial(subject, &request);
> +	landlock_log_denial(subject, &request, rule_flags);
>  	return -EACCES;
>  }
>  
> @@ -1735,7 +1735,7 @@ static int hook_file_truncate(struct file *const file)
>  #ifdef CONFIG_AUDIT
>  		.deny_masks = landlock_file(file)->deny_masks,
>  #endif /* CONFIG_AUDIT */
> -	});
> +	}, no_rule_flags);
>  	return -EACCES;
>  }
>  
> @@ -1774,7 +1774,7 @@ static int hook_file_ioctl_common(const struct file *const file,
>  #ifdef CONFIG_AUDIT
>  		.deny_masks = landlock_file(file)->deny_masks,
>  #endif /* CONFIG_AUDIT */
> -	});
> +	}, no_rule_flags);
>  	return -EACCES;
>  }
>  
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index bddbe93d69fd..0587aa3d6d0f 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -193,7 +193,8 @@ static int current_check_access_socket(struct socket *const sock,
>  				    .access = access_request,
>  				    .layer_masks = &layer_masks,
>  				    .layer_masks_size = ARRAY_SIZE(layer_masks),
> -			    });
> +			    },
> +			    rule_flags);
>  	return -EACCES;
>  }
>  
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index 43d59c7116e5..6f44804c2c9b 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -58,6 +58,11 @@ struct collected_rule_flags {
>  	layer_mask_t quiet_masks;
>  };
>  
> +/**
> + * no_rule_flags - Convenience constant for an empty collected_rule_flags
> + */
> +static const struct collected_rule_flags no_rule_flags = { 0 };

You can remove the "0" for consistency.

> +
>  /**
>   * union landlock_key - Key of a ruleset's red-black tree
>   */
> diff --git a/security/landlock/task.c b/security/landlock/task.c
> index 2385017418ca..d5bd9a1b8467 100644
> --- a/security/landlock/task.c
> +++ b/security/landlock/task.c
> @@ -115,7 +115,7 @@ static int hook_ptrace_access_check(struct task_struct *const child,
>  				.u.tsk = child,
>  			},
>  			.layer_plus_one = parent_subject->domain->num_layers,
> -		});
> +		}, no_rule_flags);
>  
>  	return err;
>  }
> @@ -161,7 +161,7 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
>  			.u.tsk = current,
>  		},
>  		.layer_plus_one = parent_subject->domain->num_layers,
> -	});
> +	}, no_rule_flags);
>  	return err;
>  }
>  
> @@ -290,7 +290,7 @@ static int hook_unix_stream_connect(struct sock *const sock,
>  			},
>  		},
>  		.layer_plus_one = handle_layer + 1,
> -	});
> +	}, no_rule_flags);
>  	return -EPERM;
>  }
>  
> @@ -327,7 +327,7 @@ static int hook_unix_may_send(struct socket *const sock,
>  			},
>  		},
>  		.layer_plus_one = handle_layer + 1,
> -	});
> +	}, no_rule_flags);
>  	return -EPERM;
>  }
>  
> @@ -383,7 +383,7 @@ static int hook_task_kill(struct task_struct *const p,
>  			.u.tsk = p,
>  		},
>  		.layer_plus_one = handle_layer + 1,
> -	});
> +	}, no_rule_flags);
>  	return -EPERM;
>  }
>  
> @@ -426,7 +426,7 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
>  #ifdef CONFIG_AUDIT
>  		.layer_plus_one = landlock_file(fown->file)->fown_layer + 1,
>  #endif /* CONFIG_AUDIT */
> -	});
> +	}, no_rule_flags);
>  	return -EPERM;
>  }
>  
> -- 
> 2.51.0
> 
