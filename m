From: gladkov.alexey@gmail.com (Alexey Gladkov)
Date: Mon, 14 May 2018 11:01:17 +0200
Subject: [PATCH v5 7/7] proc: add option to mount only a pids subset
In-Reply-To: <CAG48ez0bXvp1iF=HqyhEP1p5B6PRR07_j0qRoypJqs8x3Z+=mw@mail.gmail.com>
References: <20180511093707.GA1403@comp-core-i7-2640m-0182e6>
	<CAG48ez0bXvp1iF=HqyhEP1p5B6PRR07_j0qRoypJqs8x3Z+=mw@mail.gmail.com>
Message-ID: <20180514090117.GC28179@comp-core-i7-2640m-0182e6>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, May 11, 2018 at 03:58:39PM +0200, Jann Horn wrote:
> On Fri, May 11, 2018 at 11:37 AM, Alexey Gladkov
> <gladkov.alexey@gmail.com> wrote:
> > This allows to hide all files and directories in the procfs that are not
> > related to tasks.
> 
> /proc/$pid/net and /proc/$pid/task/$tid/net aren't in scope for this
> protection, even though they contain information about the whole
> network namespace of the task, right?

Yes. The pidonly makes visible only pids subset. You can still access the
process namespaces via /proc/$pid/ns.

We can think of additional constraints since the parameters are not
stored in the pid namespace anymore.

-- 
Rgrds, legion

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
