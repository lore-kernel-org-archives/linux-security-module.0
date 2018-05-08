From: why2jjj.linux@gmail.com (J Freyensee)
Date: Tue, 8 May 2018 09:45:57 -0700
Subject: [PATCH v1] apparmor: Convert to use match_string() helper
In-Reply-To: <20180507133903.39041-1-andriy.shevchenko@linux.intel.com>
References: <20180507133903.39041-1-andriy.shevchenko@linux.intel.com>
Message-ID: <19bebcee-d94b-42c3-7f88-70cbccdee96f@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

return 0;
> -		}
> -	}
> +	i = match_string(audit_mode_names, AUDIT_MAX_INDEX, val);
> +	if (i < 0)
> +		return -EINVAL;


Slight nitpick: according to the Linux kernel documentation, 
match_string() will return -EINVAL on failure.? You could probably just 
return 'i' if it's less than 0 and not explicitly return -EINVAL.

But good job replacing the code with a re-usable library call :-).

Reviewed-by: Jay Freyensee <why2jjj.linux@gmail.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
