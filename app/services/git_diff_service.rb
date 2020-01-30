      @diff_data += @patches.map { |patch| class_diff(patch) }
      @diff_data.compact
    def class_renamed?(patch)
      patch.select { |line| line.start_with?('-class') }.any? &&
          patch.select { |line| line.start_with?('+class') }.any?
    end

    def old_class_name(patch)
      res = patch.select { |line| line.start_with?('-class') }
      return if res.empty?
      line = res.first
      line.split(' ').last.strip
    end

    def new_class_name(patch)
      res = patch.select { |line| line.start_with?('+class') }
      return if res.empty?
      line = res.first
      line.split(' ').last.strip
    end

    def class_diff(patch)
      return { old_name: old_class_name(patch),
                         new_name: new_class_name(patch), status: :renamed_class } if class_renamed?(patch)
    end
