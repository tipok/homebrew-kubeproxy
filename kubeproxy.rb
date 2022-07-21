# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Kubeproxy < Formula
  desc "A simple HTTP proxy allowing k8s access kind of the way as it's working in the cluster itself"
  homepage ""
  url "https://github.com/tipok/kubeproxy/archive/refs/tags/v0.1.0-rc2.tar.gz"
  version "0.1.0-rc2"
  sha256 "9e40f524c200c316fe2cf508acfbe241ac13bff117b6f742b102c73f59567cbb"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X main.DefaultBuildkitdImage=earthly/buildkitd:v#{version}
      -X main.Version=v#{version}
      -X main.BuiltBy=homebrew
    ]
    tags = "dfrunmount dfrunsecurity dfsecrets dfssh dfrunnetwork"
    system "go", "build", "-tags", tags, *std_go_args(ldflags: ldflags), "./main.go"
  end

  test do
    output = shell_output("#{bin}/kubeproxy --help")
    assert_match "A HTTP proxy", output
  end
end
