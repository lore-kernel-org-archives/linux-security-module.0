From: paul@paul-moore.com (Paul Moore)
Date: Wed, 26 Apr 2017 16:04:11 -0400
Subject: [RFC][PATCH] audit: add ambient capabilities to CAPSET and
	BPRM_FCAPS records
In-Reply-To: <fb96ad9e604033a5d51607bdbb0b46f50442f5b6.1491471625.git.rgb@redhat.com>
References: <fb96ad9e604033a5d51607bdbb0b46f50442f5b6.1491471625.git.rgb@redhat.com>
Message-ID: <CAHC9VhSUc944RmVHi93m7Ht2D=gjdWcK6Lsc6Om5M9qvj7DB9g@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Apr 7, 2017 at 10:17 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Capabilities were augmented to include ambient capabilities in v4.3
> commit 58319057b784 ("capabilities: ambient capabilities").
>
> Add ambient capabilities to the audit BPRM_FCAPS and CAPSET records.
>
> The record contains fields "old_pp", "old_pi", "old_pe", "new_pp",
> "new_pi", "new_pe" so in keeping with the previous record
> normalizations, change the "new_*" variants to simply drop the "new_"
> prefix.

Help me out and remind me of those previous field rename
patches/commits where "new_X" became "X"?

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
