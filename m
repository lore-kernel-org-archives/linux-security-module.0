From: dhowells@redhat.com (David Howells)
Date: Tue, 25 Sep 2018 11:17:00 +0100
Subject: [GIT PULL] Keys: fix C++ reserved word issue
In-Reply-To: <20180925094147.GC21972@kroah.com>
References: <20180925094147.GC21972@kroah.com>
	<alpine.LRH.2.21.1809250738020.27047@namei.org>
Message-ID: <31929.1537870620@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> wrote:

> I'll wait a few days on this one...

Can you at least apply the reversion patch?  UAPI is currently broken by the
change that needs reverting.

David
