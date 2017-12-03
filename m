From: joe@perches.com (Joe Perches)
Date: Sun, 03 Dec 2017 15:20:10 -0800
Subject: [PATCH] treewide: remove duplicate includes
In-Reply-To: <1512337779-16842-1-git-send-email-pravin.shedge4linux@gmail.com>
References: <1512337779-16842-1-git-send-email-pravin.shedge4linux@gmail.com>
Message-ID: <1512343210.6321.39.camel@perches.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2017-12-04 at 03:19 +0530, Pravin Shedge wrote:
> These duplicate includes have been found with scripts/checkincludes.pl but
> they have been removed manually to avoid removing false positives.

Can you list the duplicates that were not removed as well please?

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
