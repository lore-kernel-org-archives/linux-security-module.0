From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 13 Jul 2017 07:11:36 -0500
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <20170713011554.xwmrgkzfwnibvgcu@thunk.org> (Theodore Ts'o's
	message of "Wed, 12 Jul 2017 21:15:54 -0400")
References: <1499785511-17192-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1499785511-17192-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<87mv89iy7q.fsf@xmission.com> <20170712170346.GA17974@mail.hallyn.com>
	<877ezdgsey.fsf@xmission.com>
	<74664cc8-bc3e-75d6-5892-f8934404349f@linux.vnet.ibm.com>
	<20170713011554.xwmrgkzfwnibvgcu@thunk.org>
Message-ID: <87y3rscz9j.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Theodore Ts'o <tytso@mit.edu> writes:

> I'm really confused what problem that is trying to be solved, here,
> but it **feels** really, really wrong.
>
> Why do we need to store all of this state on a per-file basis, instead
> of some kind of per-file system or per-container data structure?
>
> And how many of these security.foo at uid=bar xattrs do you expect there
> to be?  How many "foo", and how many "bar"?
>
> Maybe I missed the full write up, in which case please send me a link
> to the full writeup --- ideally in the form of a design doc that
> explains the problem statement, gives some examples of how it's going
> to be used, what were the other alternatives that were considered, and
> why they were rejected, etc.

The concise summary:

Today we have the xattr security.capable that holds a set of
capabilities that an application gains when executed.  AKA setuid root exec
without actually being setuid root.

User namespaces have the concept of capabilities that are not global but
are limited to their user namespace.  We do not currently have
filesystem support for this concept.

We currently have two proposals on the table.  One is to bump the
revision number of security.capable and add more information in that xattr.
The other is to use a sligthly different capability name.

We are currently evaluating between the two proposals.

Given that it appears the IMA xattrs will want similar treatment coming
up with a good pattern to follow is part of the analysis here.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
