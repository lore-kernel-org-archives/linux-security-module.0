From: gladkov.alexey@gmail.com (Alexey Gladkov)
Date: Mon, 14 May 2018 10:34:39 +0200
Subject: [PATCH v5 5/7] proc: instantiate only pids that we can ptrace on
	'limit_pids=1' mount option
In-Reply-To: <7c638a92-8c40-fa15-8c63-777232588137@infradead.org>
References: <20180511093613.GA1330@comp-core-i7-2640m-0182e6>
	<7c638a92-8c40-fa15-8c63-777232588137@infradead.org>
Message-ID: <20180514083439.GB28179@comp-core-i7-2640m-0182e6>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, May 11, 2018 at 09:09:04AM -0700, Randy Dunlap wrote:
> On 05/11/2018 02:36 AM, Alexey Gladkov wrote:
> > From: Djalal Harouni <tixxdz@gmail.com>
> > 
> > If "limit_pids=1" mount option is set then do not instantiate pids that
> > we can not ptrace. "limit_pids=1" means that procfs should only contain
> > pids that the caller can ptrace.
> 
> Where can I find documentation on these mount options (pidonly, limit_pids)?

The documentation is not ready yet. It will be added in the next version
of the patchset.

-- 
Rgrds, legion

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
