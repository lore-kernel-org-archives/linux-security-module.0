Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2431F4C8C
	for <linux-security-module@vger.kernel.org>; Fri, 19 Sep 2025 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297784; cv=none; b=afCwY33Xzp3+4o8yA07uF7LtcU/R+kwIhNo5xWUVDkJNyh1VFqzHKpKmAve6Xp3v5uHsARsg6M2dBEnmHPaZ9EwWaL0r1jQ1Vdiieo88i0W6j8QwZTLNDJoEcXtV56VwGy9hfB/kMrnW7lt/QPkmG07oQqk8M/EwwCnQszo43GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297784; c=relaxed/simple;
	bh=BEurYsdiobzhbPX5gGdbOyf+KOQOCLH+r4PFg0Q+lnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8SIq9jxE+qbq21txn0m1GYDZls6RYhW31ksdqd8jUrJwdZKw9e+CsjX9bYagiO77hw0k8J++gRDv3zDHSNivUK0ecS9S1282+YxO+8VIXYE1728/DnhdJx25IG7rbzdyox1UyWpFvchw3slPPQ3xGrb2AWrWu4ZrMcSQwsCZpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=YuIyMlZv; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="YuIyMlZv"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cSy2p6vrszZ1Y;
	Fri, 19 Sep 2025 18:02:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1758297778;
	bh=6KZClfQhvihyP8ULymeea4yhHRf1ZbAko6LRSqgRCyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YuIyMlZvP3t9vWEGR+CljiBfI78a4RUTuJi61yP4cnqXIjfs5C+z2kRcPh9iZ/xHT
	 T+BCzO9Z5Ayi3/YHlTZziPCytkCakFU1GNNMB2NtBeStAMFvXRmelWujiS9MDGEH2F
	 ge+rx/rt33Wv7b+wEg9F1gi6lhceSskI8QKIZu2g=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4cSy2p3fkczP3R;
	Fri, 19 Sep 2025 18:02:58 +0200 (CEST)
Date: Fri, 19 Sep 2025 18:02:57 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] landlock/audit: Check for quiet flag in
 landlock_log_denial
Message-ID: <20250919.Ohju5nie2ix8@digikod.net>
References: <cover.1757376311.git.m@maowtm.org>
 <366f215b1687eb3d530bfde11626ec0256d51180.1757376311.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <366f215b1687eb3d530bfde11626ec0256d51180.1757376311.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Tue, Sep 09, 2025 at 01:06:37AM +0100, Tingmao Wang wrote:
> Suppresses logging if the flag is effective on the youngest layer.
> 
> This does not handle optional access logging yet - to do that correctly we will
> need to expand deny_masks to support representing "don't log anything"
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
>  security/landlock/audit.c | 16 +++++++++++++++-
>  security/landlock/audit.h |  3 ++-
>  security/landlock/fs.c    | 20 +++++++++++---------
>  security/landlock/net.c   |  3 ++-
>  security/landlock/task.c  | 12 ++++++------
>  5 files changed, 36 insertions(+), 18 deletions(-)
> 
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index c52d079cdb77..2b3edd1ab374 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -386,9 +386,12 @@ static bool is_valid_request(const struct landlock_request *const request)
>   *
>   * @subject: The Landlock subject's credential denying an action.
>   * @request: Detail of the user space request.
> + * @rule_flags: The flags for the matched rule, or NULL if this is a
> + * scope request (no particular object involved).
>   */
>  void landlock_log_denial(const struct landlock_cred_security *const subject,
> -			 const struct landlock_request *const request)
> +			 const struct landlock_request *const request,
> +			 const struct collected_rule_flags *const rule_flags)

No need for a pointer for this small struct.  For scope requests,
rule_flags can just be 0, which should also simplify the following
check.

I think that's the only place where we could replace a pointer with the
(small) raw struct, but if there are other in the code, this rule should
also be applied.

>  {
>  	struct audit_buffer *ab;
>  	struct landlock_hierarchy *youngest_denied;
> @@ -436,6 +439,17 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
>  	if (!audit_enabled)
>  		return;
>  
> +	/*
> +	 * Check if the object is marked quiet by the layer that denied the

For consistency: "Checks"

> +	 * request.  (If it's a different layer that marked it as quiet, but
> +	 * that layer is not the one that denied the request, we should still
> +	 * audit log the denial)

No need for parenthesis.

> +	 */
> +	if (rule_flags &&
> +	    rule_flags->quiet_masks & BIT(youngest_layer)) {
> +		return;
> +	}
> +
>  	/* Checks if the current exec was restricting itself. */
>  	if (subject->domain_exec & BIT(youngest_layer)) {
>  		/* Ignores denials for the same execution. */
> diff --git a/security/landlock/audit.h b/security/landlock/audit.h
> index 92428b7fc4d8..e6f76d417c2f 100644
> --- a/security/landlock/audit.h
> +++ b/security/landlock/audit.h
> @@ -56,7 +56,8 @@ struct landlock_request {
>  void landlock_log_drop_domain(const struct landlock_hierarchy *const hierarchy);
>  
>  void landlock_log_denial(const struct landlock_cred_security *const subject,
> -			 const struct landlock_request *const request);
> +			 const struct landlock_request *const request,
> +			 const struct collected_rule_flags *const rule_flags);
>  
>  #else /* CONFIG_AUDIT */
>  
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index b566ae498df5..ba93b0de384c 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -984,7 +984,7 @@ static int current_check_access_path(const struct path *const path,
>  				       NULL, 0, NULL, NULL, NULL, NULL))
>  		return 0;
>  
> -	landlock_log_denial(subject, &request);
> +	landlock_log_denial(subject, &request, &rule_flags);
>  	return -EACCES;
>  }
>  
> @@ -1194,7 +1194,7 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>  			    &request1, NULL, 0, NULL, NULL, NULL, NULL))
>  			return 0;
>  
> -		landlock_log_denial(subject, &request1);
> +		landlock_log_denial(subject, &request1, &rule_flags_parent1);
>  		return -EACCES;
>  	}
>  
> @@ -1243,11 +1243,13 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>  
>  	if (request1.access) {
>  		request1.audit.u.path.dentry = old_parent;
> -		landlock_log_denial(subject, &request1);
> +		landlock_log_denial(subject, &request1,
> +				    &rule_flags_parent1);
>  	}
>  	if (request2.access) {
>  		request2.audit.u.path.dentry = new_dir->dentry;
> -		landlock_log_denial(subject, &request2);
> +		landlock_log_denial(subject, &request2,
> +				    &rule_flags_parent2);
>  	}
>  
>  	/*
> @@ -1403,7 +1405,7 @@ log_fs_change_topology_path(const struct landlock_cred_security *const subject,
>  			.u.path = *path,
>  		},
>  		.layer_plus_one = handle_layer + 1,
> -	});
> +	}, NULL);
>  }
>  
>  static void log_fs_change_topology_dentry(
> @@ -1417,7 +1419,7 @@ static void log_fs_change_topology_dentry(
>  			.u.dentry = dentry,
>  		},
>  		.layer_plus_one = handle_layer + 1,
> -	});
> +	}, NULL);
>  }
>  
>  /*
> @@ -1705,7 +1707,7 @@ static int hook_file_open(struct file *const file)
>  
>  	/* Sets access to reflect the actual request. */
>  	request.access = open_access_request;
> -	landlock_log_denial(subject, &request);
> +	landlock_log_denial(subject, &request, &rule_flags);
>  	return -EACCES;
>  }
>  
> @@ -1735,7 +1737,7 @@ static int hook_file_truncate(struct file *const file)
>  #ifdef CONFIG_AUDIT
>  		.deny_masks = landlock_file(file)->deny_masks,
>  #endif /* CONFIG_AUDIT */
> -	});
> +	}, NULL);
>  	return -EACCES;
>  }
>  
> @@ -1774,7 +1776,7 @@ static int hook_file_ioctl_common(const struct file *const file,
>  #ifdef CONFIG_AUDIT
>  		.deny_masks = landlock_file(file)->deny_masks,
>  #endif /* CONFIG_AUDIT */
> -	});
> +	}, NULL);
>  	return -EACCES;
>  }
>  
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index bddbe93d69fd..d242bb9fa5b4 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -193,7 +193,8 @@ static int current_check_access_socket(struct socket *const sock,
>  				    .access = access_request,
>  				    .layer_masks = &layer_masks,
>  				    .layer_masks_size = ARRAY_SIZE(layer_masks),
> -			    });
> +			    },
> +			    &rule_flags);
>  	return -EACCES;
>  }
>  
> diff --git a/security/landlock/task.c b/security/landlock/task.c
> index 2385017418ca..dfea227ce1d7 100644
> --- a/security/landlock/task.c
> +++ b/security/landlock/task.c
> @@ -115,7 +115,7 @@ static int hook_ptrace_access_check(struct task_struct *const child,
>  				.u.tsk = child,
>  			},
>  			.layer_plus_one = parent_subject->domain->num_layers,
> -		});
> +		}, NULL);
>  
>  	return err;
>  }
> @@ -161,7 +161,7 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
>  			.u.tsk = current,
>  		},
>  		.layer_plus_one = parent_subject->domain->num_layers,
> -	});
> +	}, NULL);
>  	return err;
>  }
>  
> @@ -290,7 +290,7 @@ static int hook_unix_stream_connect(struct sock *const sock,
>  			},
>  		},
>  		.layer_plus_one = handle_layer + 1,
> -	});
> +	}, NULL);
>  	return -EPERM;
>  }
>  
> @@ -327,7 +327,7 @@ static int hook_unix_may_send(struct socket *const sock,
>  			},
>  		},
>  		.layer_plus_one = handle_layer + 1,
> -	});
> +	}, NULL);
>  	return -EPERM;
>  }
>  
> @@ -383,7 +383,7 @@ static int hook_task_kill(struct task_struct *const p,
>  			.u.tsk = p,
>  		},
>  		.layer_plus_one = handle_layer + 1,
> -	});
> +	}, NULL);
>  	return -EPERM;
>  }
>  
> @@ -426,7 +426,7 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
>  #ifdef CONFIG_AUDIT
>  		.layer_plus_one = landlock_file(fown->file)->fown_layer + 1,
>  #endif /* CONFIG_AUDIT */
> -	});
> +	}, NULL);
>  	return -EPERM;
>  }
>  
> -- 
> 2.51.0
> 
> 
