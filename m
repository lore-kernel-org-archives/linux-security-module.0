From: tytso@mit.edu (Theodore Ts'o)
Date: Wed, 12 Jul 2017 21:15:54 -0400
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <74664cc8-bc3e-75d6-5892-f8934404349f@linux.vnet.ibm.com>
References: <1499785511-17192-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1499785511-17192-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<87mv89iy7q.fsf@xmission.com>
	<20170712170346.GA17974@mail.hallyn.com>
	<877ezdgsey.fsf@xmission.com>
	<74664cc8-bc3e-75d6-5892-f8934404349f@linux.vnet.ibm.com>
Message-ID: <20170713011554.xwmrgkzfwnibvgcu@thunk.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

I'm really confused what problem that is trying to be solved, here,
but it **feels** really, really wrong.

Why do we need to store all of this state on a per-file basis, instead
of some kind of per-file system or per-container data structure?

And how many of these security.foo at uid=bar xattrs do you expect there
to be?  How many "foo", and how many "bar"?

Maybe I missed the full write up, in which case please send me a link
to the full writeup --- ideally in the form of a design doc that
explains the problem statement, gives some examples of how it's going
to be used, what were the other alternatives that were considered, and
why they were rejected, etc.

Thanks,

					- Ted
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
