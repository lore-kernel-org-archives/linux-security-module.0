From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Mon, 4 Dec 2017 10:54:28 -0800
Subject: [PATCH tip/core/rcu 15/21] keyring: Remove now-redundant
	smp_read_barrier_depends()
In-Reply-To: <alpine.LFD.2.20.1712041159130.1348@localhost>
References: <20171201195053.GA23494@linux.vnet.ibm.com>
	<1512157876-24665-15-git-send-email-paulmck@linux.vnet.ibm.com>
	<alpine.LFD.2.20.1712041159130.1348@localhost>
Message-ID: <20171204185428.GC7829@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Dec 04, 2017 at 11:59:22AM +1100, James Morris wrote:
> On Fri, 1 Dec 2017, Paul E. McKenney wrote:
> 
> > Now that the associative-array library properly heads dependency chains,
> > the various smp_read_barrier_depends() calls in security/keys/keyring.c
> > are no longer needed.  This commit therefore removes them.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: James Morris <james.l.morris@oracle.com>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: <keyrings@vger.kernel.org>
> > Cc: <linux-security-module@vger.kernel.org>
> 
> Reviewed-by: James Morris <james.l.morris@oracle.com>

Applied, thank you for the review!

							Thanx, Paul

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
